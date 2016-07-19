// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokekonAbilities.swift instead.

import CoreData

public enum RCGPokekonAbilitiesRelationships: String {
    case pokemon = "pokemon"
}

@objc public
class _RCGPokekonAbilities: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokekonAbilities"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokekonAbilities.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    // MARK: - Relationships

    @NSManaged public
    var pokemon: RCGPokemon?

    // func validatePokemon(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

