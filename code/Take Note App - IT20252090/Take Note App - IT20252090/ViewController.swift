//
//  ViewController.swift
//  Take Note App - IT20252090
//
//  Created by Priyankara on 2023-04-16.
//

import UIKit
import CoreData

class ViewController: UIViewController
{
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedNote: Note? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // If selectedNote is not nil, populate the text fields with its data
        if(selectedNote != nil)
        {
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
    }

    @IBAction func saveAction(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
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
            catch
            {
                // If there was an error saving the new note, print an error message
                print("context save error")
            }
        }
        else // If editing an existing note
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                
                // Iterate over all the notes in Core Data
                for result in results
                {
                    let note = result as! Note
                    
                    // If the current note matches the selected note, update its values and save it to Core Data
                    if(note == selectedNote)
                    {
                        note.title = titleTF.text
                        note.desc = descTV.text
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
    }
    
    @IBAction func DeleteNote(_ sender: Any)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            
            // Iterate over all the notes in Core Data
            for result in results
            {
                let note = result as! Note
                
                // If the current note matches the selected note, mark it as deleted and save it to Core Data
                if(note == selectedNote)
                {
                    note.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        catch
        // If there was an error fetching the notes
        {
            print("Fetch Failed")
        }
    }
    
}

