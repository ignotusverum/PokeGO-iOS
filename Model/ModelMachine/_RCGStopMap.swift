// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGStopMap.swift instead.

import CoreData

public enum RCGStopMapAttributes: String {
    case latitude = "latitude"
    case longitude = "longitude"
    case lureExpiration = "lureExpiration"
    case luredPokemonID = "luredPokemonID"
    case stopID = "stopID"
}

public enum RCGStopMapRelationships: String {
    case luredPokemon = "luredPokemon"
}

@objc public
class _RCGStopMap: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGStopMap"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGStopMap.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var latitude: NSNumber?

    // func validateLatitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var longitude: NSNumber?

    // func validateLongitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var lureExpiration: NSDate?

    // func validateLureExpiration(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var luredPokemonID: NSNumber?

    // func validateLuredPokemonID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var stopID: String?

    // func validateStopID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var luredPokemon: RCGPokemon?

    // func validateLuredPokemon(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

