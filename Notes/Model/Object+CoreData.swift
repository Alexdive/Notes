//
//  Object+CoreData.swift
//  Notes
//
//  Created by Aleksei Permiakov on 08.04.2023.
//

import CoreData

public protocol ObjectID: AnyObject {}

extension NSManagedObjectID: ObjectID {}
