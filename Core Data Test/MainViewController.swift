import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet var textUsername: UITextField
    @IBOutlet var textPassword: UITextField
    
    func getStorageContext() -> NSManagedObjectContext {
        var appDelegate:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        return appDelegate.managedObjectContext
    }
    
    @IBAction func buttonLoadClick() {
        var context = getStorageContext()
        
        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "username = %@", textUsername.text as String)
        
        var results = context.executeFetchRequest(request, error: nil)
        
        if results.count > 0 {
            // good!
            var firstEntry = results[0] as NSManagedObject
            textUsername.text = firstEntry.valueForKey("username") as String
            textPassword.text = firstEntry.valueForKey("password") as String
            return
        }
        
        println("0 results returned... potential error.")
    }
    
    @IBAction func buttonSaveClick() {
        var context = getStorageContext()
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        
        newUser.setValue(textUsername.text as String, forKey: "username")
        newUser.setValue(textPassword.text as String, forKey: "password")
        
        context.save(nil)
        
        println(newUser)
        println("object saved")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } 
    

}
