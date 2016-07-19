// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokemonMove.swift instead.

import CoreData

public enum RCGPokemonMoveRelationships: String {
    case pokemon = "pokemon"
}

@objc public
class _RCGPokemonMove: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokemonMove"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokemonMove.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    // MARK: - Relationships

    @NSManaged public
    var pokemon: RCGPokemon?

    // func validatePokemon(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

}

