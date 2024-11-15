//
// Copyright © Essential Developer. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ManagedFeedImage)
final class ManagedFeedImage: NSManagedObject {
	@NSManaged public var id: UUID
	@NSManaged public var imageDescription: String?
	@NSManaged public var location: String?
	@NSManaged public var url: URL
	@NSManaged public var cache: ManagedCache
}

extension ManagedFeedImage {
	static func images(from localFeed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
		let listOfManagedObjects = localFeed.map { local in
			let singleManagedObj = createSingleManagedObject(from: local, in: context)
			return singleManagedObj
		}
		return NSOrderedSet(array: listOfManagedObjects)
	}

	private static func createSingleManagedObject(from local: LocalFeedImage, in context: NSManagedObjectContext) -> NSManagedObject {
		let managed = ManagedFeedImage(context: context)
		managed.id = local.id
		managed.imageDescription = local.description
		managed.location = local.location
		managed.url = local.url
		return managed
	}

	var local: LocalFeedImage {
		return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
	}
}
