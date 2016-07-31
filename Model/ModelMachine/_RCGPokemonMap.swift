// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokemonMap.swift instead.

import CoreData

public enum RCGPokemonMapAttributes: String {
    case disappearTime = "disappearTime"
    case encounterID = "encounterID"
    case latitude = "latitude"
    case longitude = "longitude"
    case pokemonID = "pokemonID"
    case spawnpointID = "spawnpointID"
}

public enum RCGPokemonMapRelationships: String {
    case pokemon = "pokemon"
}

@objc public
class _RCGPokemonMap: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokemonMap"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokemonMap.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var disappearTime: NSNumber?

    // func validateDisappearTime(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var encounterID: String?

    // func validateEncounterID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var latitude: NSNumber?

    // func validateLatitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var longitude: NSNumber?

    // func validateLongitude(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var pokemonID: NSNumber?

    // func validatePokemonID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var spawnpointID: String?

    // func validateSpawnpointID(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var pokemon: RCGPokemon?

    // func validatePokemon(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

