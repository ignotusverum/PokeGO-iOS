// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RCGPokemon.swift instead.

import CoreData

public enum RCGPokemonAttributes: String {
    case height = "height"
    case weight = "weight"
}

public enum RCGPokemonRelationships: String {
    case abilities = "abilities"
    case stats = "stats"
}

@objc public
class _RCGPokemon: RCGModel {

    // MARK: - Class methods

    override public class func entityName () -> String {
        return "RCGPokemon"
    }

    override public class func entity(managedObjectContext: NSManagedObjectContext!) -> NSEntityDescription! {
        return NSEntityDescription.entityForName(self.entityName(), inManagedObjectContext: managedObjectContext);
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext!) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    public convenience init(managedObjectContext: NSManagedObjectContext!) {
        let entity = _RCGPokemon.entity(managedObjectContext)
        self.init(entity: entity, insertIntoManagedObjectContext: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged public
    var height: NSNumber?

    // func validateHeight(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    @NSManaged public
    var weight: NSNumber?

    // func validateWeight(value: AutoreleasingUnsafeMutablePointer<AnyObject>, error: NSErrorPointer) -> Bool {}

    // MARK: - Relationships

    @NSManaged public
    var abilities: NSSet

    @NSManaged public
    var stats: NSSet

}

extension _RCGPokemon {

    func addAbilities(objects: NSSet) {
        let mutable = self.abilities.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.abilities = mutable.copy() as! NSSet
    }

    func removeAbilities(objects: NSSet) {
        let mutable = self.abilities.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.abilities = mutable.copy() as! NSSet
    }

    func addAbilitiesObject(value: RCGPokekonAbilities!) {
        let mutable = self.abilities.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.abilities = mutable.copy() as! NSSet
    }

    func removeAbilitiesObject(value: RCGPokekonAbilities!) {
        let mutable = self.abilities.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.abilities = mutable.copy() as! NSSet
    }

}

extension _RCGPokemon {

    func addStats(objects: NSSet) {
        let mutable = self.stats.mutableCopy() as! NSMutableSet
        mutable.unionSet(objects as Set<NSObject>)
        self.stats = mutable.copy() as! NSSet
    }

    func removeStats(objects: NSSet) {
        let mutable = self.stats.mutableCopy() as! NSMutableSet
        mutable.minusSet(objects as Set<NSObject>)
        self.stats = mutable.copy() as! NSSet
    }

    func addStatsObject(value: RCGPokemonStats!) {
        let mutable = self.stats.mutableCopy() as! NSMutableSet
        mutable.addObject(value)
        self.stats = mutable.copy() as! NSSet
    }

    func removeStatsObject(value: RCGPokemonStats!) {
        let mutable = self.stats.mutableCopy() as! NSMutableSet
        mutable.removeObject(value)
        self.stats = mutable.copy() as! NSSet
    }

}

