import UIKit
import os.log
//Important: NoteTableViewController has no _direct_ access to categories, it is given some category

class NoteTableViewController: UITableViewController {
    //MARK: - Properties
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleNotes()
         self.navigationItem.leftBarButtonItem = self.editButtonItem //system edit button in the navigation bar for editing the table view
       
        // Load any saved notes, otherwise load sample data.
        if let savedNotes = loadNotes(){
            notes += savedNotes
        }else{
            //Load the sample data
            loadSampleNotes()
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "NoteTableViewCell"
        // Table view cells are reused and should be dequeued using a cell identifier.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NoteTableViewCell else {
            fatalError("The dequeued cell is not an instance of NoteTableViewCell.")
        }
    
        // Fetches the appropriate note for the data source layout.
        let note = notes[indexPath.row]
        cell.title.text = note.title
        cell.colorLabel.backgroundColor = note.category.color
        cell.textExtract.text = note.text + "..." 
        
        return cell
    }
    
    //MARK: - TableView Editing
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            notes.remove(at: indexPath.row)
            saveNotes()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } 
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editNote"){
            guard let NoteViewController = segue.destination as? NoteViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedNoteCell = sender as? NoteTableViewCell else{
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedNoteCell) else{
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let note = notes[indexPath.row]
            NoteViewController.note = note
        }
    }
    
    
    //MARK: - Actions
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? NoteViewController, let note = sourceViewController.note {
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                //Update an existing category
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                //Add a new note
                let newIndexPath = IndexPath(row: notes.count, section: 0)
                notes.append(note)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            //Save notes
            saveNotes()
        }
    }
    //MARK: - Private Methods
    func loadSampleNotes(){
        guard let category1 = Category(name: "Feeling Proud", color: .brown) else{
            fatalError("Unable to instantiate category1")
        }
        guard let note1 = Note(title: "Won Scholarship!", category: category1, text: "Today I opened my email from Harvard to read that I was admitted for the full ride scholarship...") else{
            fatalError("Unable to instantiate note1")
        }
        
        guard let category2 = Category(name: "Feeling Happy", color: .blue) else{
            fatalError("Unable to instantiate category2")
        }
        
        guard let note2 = Note(title: "Bought a book!", category: category2, text: "Today I bought a book in the local store...") else{
            fatalError("Unable to instantiate note2")
        }
        
        guard let category3 = Category(name: "Feeling Grateful", color: .red) else{
            fatalError("Unable to instantiate category3")
        }
        guard let note3 = Note(title: "Wished HB to my mom!", category: category3, text: "Today we celebrated mom's BD, and we just had the best day in our lives! She sang a song for me and we'd think about what our life was like when we had our daddy...") else{
            fatalError("Unable to instantiate note3")
        }
        
        guard let category4 = Category(name: "Feeling Strong", color: .purple) else{
            fatalError("Unable to instantiate category4")
        }
        guard let note4 = Note(title: "YouTube video on the meaning of life", category: category4, text: "The video I watched yesterday morning gave me a different feeling...") else{
            fatalError("Unable to instantiate note3")
        }
        
        notes += [note1, note2, note3, note4]
    }
    
    private func saveNotes(){
        //Archiving (Saving)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(notes, toFile: Note.ArchiveURL.path)
        
        if isSuccessfulSave{
            os_log("Notes successfully saved.", log: OSLog.default, type: .debug)
        }else{
            os_log("Failed to save notes...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadNotes() -> [Note]?{
        //Unarchiving (retrieving)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Note.ArchiveURL.path) as? [Note]
    }
}
