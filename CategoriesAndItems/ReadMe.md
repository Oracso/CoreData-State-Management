#  CategoriesAndItems ReadMe


 








CoreData Model

-   Add Entity properties and create NSManagedObjectSubclass files



Entity Extensions 

-   Create unwrapped entity property variables
-   Add NSSortDescriptor key to objectStoreFetchRequest()







## On Start-Up



CoreData Model:

(don't need some of this now as have editied the model)
- Define Entities
    - Rename Entities
    - Add attributes
    - Add entity relationships
- Create NSManagedObject Subclasses
- Delete Identifiable conformance extension in each EntityProperties file
- Add Codable conformance to Entity Subclasses
    - Remove code from EntityExtensions to Entity class defintion file
    - Complete Codable conformance code
- Add unwrappedProperties to EntityExtension (Only for optional CoreData attrubutes that aren't actually optional..)
- Add NSSortDescriptor property to each objectStoreFetchRequest() in EntityExtensions (until writen code to fix)

- RelationalEntity Conformance (on EntityExtensions):
    - Add cases for Relationships enum
    - Add switch statement to returnRelationship(), returnRelationshipEntityType() and inverseRelationshipName()

- ObjectPlaceholderCompatible Conformance (on EntityExtensions)


EntityDetailViews:
- Rename DetailView folders from EntityOne/Two to Entity names
- Add entity properties to view
- Add 

GenericViewManager:
- Edit entityListRowView, as property may not be name

AddObjectViews:
- Add Entity property inputs 



CoreDataManagers:
- CoreDataModifier
    - Add default attributes to createEntity()
- CoreDataPreviewManager
    - Add randomised input parameters to createObjectFromRandomisedObjectData()

If Relational Entities:
- Uncomment linkOneToManyEntitiesGeneric() in initExampleData() on CoreDataPreviewManager file
- ObjectPlaceholderDetailsManager:
    - Edit the toOne & toMany CustomUUID properties of createEntityPlaceholderDetails()



## Define New Entity

- Add conformance to ToManyEntity protocol in ToManyEntity file 

CoreData Model:
- Define Entities
    - Add attributes
    - Add UUID id attribute and set it as the entity constraint (For CustomUUID conformance) (not if using iCloud)
    - Set Codegen to Manual/None 
    - Add entity relationships
- Create NSManagedObject Subclasses
- Delete Identifiable conformance extension in each EntityProperties file
- Add Codable conformance to Entity Subclasses


- Add Entity name to EntityType enum
    - Add conformance to other parts of code:
        - EntityType extenstions
        
        - DataDownloadView

- Add castedAsEntity() to NSManagedObject Extensions

- Add Entity to AppDataStore Heirachy:
    - Create new EntityObjectStore
    - Add new ObjectStore to AppObjectStores


- Add createEntityPlaceholderDetails() to ObjectPlaceholderDetailsManager


If Relational Entities:
- Create then tailor createEntityPlaceholderDetails() on ObjectPlaceholderDetailsManager
- Add ToManyEntity protocol conformance if To->Many relationship
 

If using relationship NSSet? often, then add computed property which uses .unwrap(T.self) for beverity


## Update Entity Attributes 



## Delete Entity



## Convert to NSPersistentCloudKitContainer

- How to:
    - https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/setting_up_core_data_with_cloudkit

- what is not supported in cloudkit model??
    - https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/creating_a_core_data_model_for_cloudkit




- Add to Signing & Capabilities:
    - iCloud
        - Check CloudKit
        - Create/Select Container

    - Background Modes
        - Check Remote Notificaitons

- Check "Used with CloudKit" on CoreDataModel in the Inspector Panel on Defualt/Custom Configurations 

- Change inMemory = false in the CoreDataManager init()

- Change NSPersistentContainerSubClass from NSPersistentContainer to NSPersistentCloudKitContainer

- (Remove Entity Constraints)





Attributes that are intended to be optional in Core Data must be optional (you can't write your own @NSManaged var name: String definition, which XCode would by default generate to be of type String?).

Attributes that Core Data expects to be non-optional, such as Integer16 and Boolean and Double, must always have a default value. for a Date or a UUID, which come across in Swift to be of type Date? and UUID?, just leave the Default button unchecked in the model editor.

Relationships must be unordered (so, an NSSet? and not an NSOrderedSet?). if you have an ordered relationship, you'll have to keep the order somewhere else (possibly as an [Int] in one of the entities, or in another entity whose purpose is to track order in the relationship).

### Notes:

CoreData - NSManagedObject -> NSManagedObjectModel -> NSPersistentStore
CloudKit - CKRecord -> Schema -> CKRecordZone / CKDatabase

"We do manage a specific custom zone for CoreData syncing"
"they use a custom zone for apps that use the Core Data/CloudKit integration"
"When record name is combined with a zone identifier we get a CKRecordID" - How would this work with my CustomUUID



"It's with the way I'm fetching from Core Data. It works when I use a NSFetchedResultsController where I get updates of changes in iCloud in the delegate method: controllerWillChangeContent
"fetch request is going off before the NSPeristentCloudKitContainer subscription is fully set up"


#### To See Records in iCloud Developer Portal:
- Select Container
- Go to prvate database 
- Selected the custom zone (for coredata/cloudkit integration?)
- Specify record 
(Ensure record is marked as queirable)