import UIKit
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
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
            dismiss(animated: true, completion: nil)
    }

    
    
    
    //MARK: - Private Methods
    private func updateSaveButtonState(){
        //Disable the Save button if the title and text are empty.
        let title = titleTextView.text ?? ""
        let text = textTextView.text ?? ""
        saveButton.isEnabled = !text.isEmpty && !title.isEmpty
    }
}
