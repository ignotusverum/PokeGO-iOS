// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokemonStats.swift instead.

import CoreData

public enum RCGPokemonStatsAttributes: String {
    case baseStat = "baseStat"
    case effort = "effort"
    case name = "name"
}

public enum RCGPokemonStatsRelationships: String {
    case pokemon = "pokemon"
}

@objc public
class _RCGPokemonStats: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokemonStats"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokemonStats.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var baseStat: NSNumber?

    // func validateBaseStat(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var effort: NSNumber?

    // func validateEffort(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var name: String?

    // func validateName(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var pokemon: RCGPokemon?

    // func validatePokemon(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

