<p align="center">
  <img src="Resources/Logo.png" width="250"/> &nbsp;
</p>

# Project Name - Take Note

#### 01. Brief Description of Project :- 

My ISO application is designed to help busy individuals keep track of important tasks and information that can be easily forgotten due to a hectic lifestyle. My application offers a range of features, including reminders, to-do lists, and note-taking capabilities. It is designed for busy professionals, students, and anyone who needs help staying organized and remembering important tasks. My application has a user-friendly interface and offers advanced customization options that set it apart from similar applications. It was built using the Swift programming language.

#### 02. Users of the System :-

Students and Employed Persons.

#### 03. What is unique about your solution :-

Creating an ISO application to remember things that are difficult to remember due to people busy lifestyle.

#### 04. Briefly document the functionality of the screens you have (Include screen shots of images) :-

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⍟ &nbsp; iPhone related screenshots - <br />

<p align="center">
<img src="Resources/UI 1 - Home page.png" height="500"/> &nbsp;
<img src="Resources/UI 2 - List of notes.png" height="500"/> &nbsp;
<img src="Resources/UI 3 - Create a new note.png" height="500"/> &nbsp;
<img src="Resources/UI 4 - Update & Delete page.png" height="500"/> &nbsp;
</p>  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ⍟ &nbsp; iPad related screenshots - <br />

<p align="center">
<img src="Resources/UI 5 - Home page.png" height="500"/> &nbsp;
<img src="Resources/UI 6 - List of notes.png" height="500"/> &nbsp;
<img src="Resources/UI 7 - Create a new note.png" height="500"/> &nbsp;
<img src="Resources/UI 8 - Update & Delete page.png" height="500"/> &nbsp;
</p>

#### 05. Give examples of best practices used when writing code :-
The code below uses,

- variables
```
class Note: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}

```

- class
```
class ViewController: UIViewController
{
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if(selectedNote != nil)
        {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
    }
```

- Error handling (try - catch)
```
@IBAction func DeleteNote(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results
            {
                let note = result as! Note
                if(note == selectedNote)
                {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        {
            print("Fetch Failed")
        }
    }
```

- Comments
```
 // If creating a new note
    if(selectedNote == nil)
        {
            let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
            let newNote = Note(entity: entity!, insertInto: context)
            newNote.id = noteList.count as NSNumber
            newNote.title = titleTF.text
            newNote.desc = descTV.text
            
            // Attempt to save the new note to Core Data
            do
            {
                try context.save()
                noteList.append(newNote)
                navigationController?.popViewController(animated: true)
            }
```

#### 06. UI Components used :-

The following components were used,
- UIButton
- UIViewController
- UINavigationController
- UITableView
- TextField

#### 07. Testing carried out :- 

The following classes implemented unit testing for the ```NoteTableViewTests```. 

```
import XCTest
import CoreData
@testable import TakeNoteApp

class NoteTableViewTests: XCTestCase {
    
    var noteTableView: NoteTableView!
    
    override func setUp() {
        super.setUp()
        
        // Set up the managed object context
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        // Create some notes to populate the noteList
        let note1 = Note(context: context)
        note1.id = 1
        note1.title = "Note 1"
        note1.desc = "This is note 1"
        note1.deletedDate = nil
        
        let note2 = Note(context: context)
        note2.id = 2
        note2.title = "Note 2"
        note2.desc = "This is note 2"
        note2.deletedDate = Date()
        
        noteList = [note1, note2] // Populate the noteList with the notes
        
        // Create a NoteTableView instance for testing
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        noteTableView = storyboard.instantiateViewController(withIdentifier: "noteTableViewID") as? NoteTableView
        noteTableView.loadViewIfNeeded() // Load the view hierarchy
    }
    
    func testNonDeletedNotes() {
        let nonDeletedNotes = noteTableView.nonDeletedNotes()
        XCTAssertEqual(nonDeletedNotes.count, 1)
        XCTAssertEqual(nonDeletedNotes[0].id, 1)
    }
    
    func testTableViewDataSource() {
        let numberOfRows = noteTableView.tableView(noteTableView.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1)
        
        let cell = noteTableView.tableView(noteTableView.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! NoteCell
        XCTAssertEqual(cell.titleLabel.text, "Note 1")
        XCTAssertEqual(cell.descLabel.text, "This is note 1")
    }
    
    func testTableViewDelegate() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "viewControllerID") as! ViewController
        noteTableView.performSegue(withIdentifier: "editNote", sender: vc)
        XCTAssertTrue(vc.isBeingPresented)
        
        let indexPath = IndexPath(row: 0, section: 0)
        noteTableView.tableView(noteTableView.tableView, didSelectRowAt: indexPath)
        let selectedNote = vc.selectedNote
        XCTAssertEqual(selectedNote?.id, 1)
    }
    
}
```

#### 08. Documentation :- 

(a) Design Choices :

- Simple and intuitive interface: The user interface should be simple and intuitive, allowing users to quickly navigate through the application and find what they need. Use a clean and modern design, with easy-to-read fonts, and clear graphics.
- Customizable options: Offer customizable options, such as different themes, color schemes, and font sizes, so that users can personalize the application to their preferences.

(b) Implementation Decisions :

- Selection of programming language and platform: Based on my expertise and resources, choose a programming language and platform to develop the app using Swift for iOS.
- Data storage and management: How to store and manage data must be decided. A database-based service such as CoreData can also be used.

(c) Challenges :

- User adoption: convincing users to adopt and use the application regularly.
- Design and usability: creating a user-friendly and intuitive interface.
- Technical difficulties: dealing with potential technical issues and bugs during development.
- Competition: standing out in a market with many similar applications.
- Feedback and improvement: gathering feedback and making necessary improvements to ensure the application meets the needs of its users.

#### 09. Reflection :-

- The assignment helped me think through the design and implementation decisions that need to be made when developing a mobile application.
- Lack of familiarity with the programming language and development platform required for the project required additional time and effort to learn the necessary skills.
- Another challenge is ensuring that the app meets the needs and expectations of the target audience.

  

