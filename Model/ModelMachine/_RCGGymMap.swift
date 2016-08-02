// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGGymMap.swift instead.

import CoreData

public enum RCGGymMapAttributes: String {
    case guardingID = "guardingID"
    case identifier = "identifier"
    case latitude = "latitude"
    case longitude = "longitude"
    case points = "points"
    case team = "team"
}

public enum RCGGymMapRelationships: String {
    case pokemonGuard = "pokemonGuard"
}

@objc public
class _RCGGymMap: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGGymMap"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGGymMap.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var guardingID: NSNumber?

    // func validateGuardingID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var identifier: String?

    // func validateIdentifier(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var latitude: NSNumber?

    // func validateLatitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var longitude: NSNumber?

    // func validateLongitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var points: NSNumber?

    // func validatePoints(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var team: NSNumber?

    // func validateTeam(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var pokemonGuard: RCGPokemon?

    // func validatePokemonGuard(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

