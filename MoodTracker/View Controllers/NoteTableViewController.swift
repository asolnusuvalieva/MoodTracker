import UIKit
//Important: NoteTableViewController has no right access to categories, it is given some category

class NoteTableViewController: UITableViewController {
    //MARK: - Properties
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleNotes()
         self.navigationItem.leftBarButtonItem = self.editButtonItem //system edit button in the navigation bar for editing the table view
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
        cell.textExtract.text = note.text //FIXME
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Actions
    @IBAction func unwindToNoteList(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? NoteViewController, let note = sourceViewController.note {
            
            
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
        guard let note3 = Note(title: "Wished HB to my mom!", category: category3, text: "Today we celebrated mom's BD...") else{
            fatalError("Unable to instantiate note3")
        }
        
        notes += [note1, note2, note3]
    }
}
