import UIKit
import os.log

//SHOULD RETURN NOTE
class NoteViewController: UITableViewController, UITextViewDelegate {
    //MARK: Properties
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var textTextView:UITextView!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //Not that much relevant properties
    var selectedSection = -1
    var selectedRow = -1
    var noteCategoriesVisited = false
    /*
    This value is either passed by `NoteTableViewController` in `prepare(for:sender:)`
    or constructed as part of adding a new note.
    */
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle the textView's user input through delegate callbacks.
        titleTextView.delegate = self
        textTextView.delegate = self
        
        // Enable the Save button only if the text field has a valid Category name.
        updateSaveButtonState()
        
        //Adding done button in the tool bar for textTextView
        textTextView.addDoneButton()
        colorLabel.backgroundColor = .none
        
        // Set up views if editing an existing Note
        if let note = self.note{
            navigationItem.title = note.title
            titleTextView.text = note.title
            textTextView.text = note.text
            categoryLabel.text = note.category.name
            colorLabel.backgroundColor = note.category.color
        }
    }
    
    //MARK: - TextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //during editing `saveButton` should be disabled
        if textView == titleTextView || textView == textTextView{
            saveButton.isEnabled = false
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //in case of titleTextView, the keyboard should be dismissed when `return` is tapped
        if(textView == titleTextView && text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
        navigationItem.title = titleTextView.text
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if segue.identifier == "NoteCategoriesTableViewControllerCell"{
            
            guard let noteCategoriesTableViewController = segue.destination as? NoteCategoriesTableViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            //if it's 1st time opening then no checkmark for anything
            if(categoryLabel.text == "Category"){
                selectedRow = -1
                selectedSection = -1
            }
            
            noteCategoriesTableViewController.selectedRow = selectedRow
            noteCategoriesTableViewController.selectedSection = selectedSection
        }
        
        // Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button == saveButton else{
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        let noteName = titleTextView.text ?? ""
        let noteText = textTextView.text ?? ""
        
        let categoryName = noteCategoriesVisited ? categoryLabel.text! : ""
        let categoryColor = noteCategoriesVisited ? colorLabel.backgroundColor! : nil //here we can't provide default color since we work only with existing categories 
        let category = Category(name: categoryName, color: categoryColor)// nil or category 
        self.note = Note(title: noteName, category: category, text: noteText) //note or nil
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddNoteMode = presentingViewController is UINavigationController
        if isPresentingInAddNoteMode{
            dismiss(animated: true, completion: nil)
        }else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }else{
            fatalError("The NoteViewController is not inside a navigation controller.")
        }

    }
    
    //MARK: - Private Methods
    private func updateSaveButtonState(){
        //Disable the Save button if the title and text are empty.
        let title = titleTextView.text ?? ""
        let text = textTextView.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !title.isEmpty
    }
}
