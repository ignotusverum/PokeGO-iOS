// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokemonType.swift instead.

import CoreData

public enum RCGPokemonTypeRelationships: String {
    case pokemon = "pokemon"
}

@objc public
class _RCGPokemonType: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokemonType"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokemonType.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    // MARK: - Relationships

    @NSManaged public
    var pokemon: NSSet

}

extension _RCGPokemonType {

    func addPokemon(objects: NSSet) {
        let mutable = self.pokemon.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.pokemon = mutable.copy() as! NSSet
    }

    func removePokemon(objects: NSSet) {
        let mutable = self.pokemon.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.pokemon = mutable.copy() as! NSSet
    }

    func addPokemonObject(value: RCGPokemon!) {
        let mutable = self.pokemon.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.pokemon = mutable.copy() as! NSSet
    }

    func removePokemonObject(value: RCGPokemon!) {
        let mutable = self.pokemon.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.pokemon = mutable.copy() as! NSSet
    }

}

