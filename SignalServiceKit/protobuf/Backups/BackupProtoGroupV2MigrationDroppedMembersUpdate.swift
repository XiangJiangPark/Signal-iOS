//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupV2MigrationDroppedMembersUpdate in Backup.proto
import Wire

/**
 * The local user migrated gv1->gv2 but was unable to
 * add or invite some members and dropped them instead.
 * (Happens for e164 members where we don't have an aci).
 */
public struct BackupProtoGroupV2MigrationDroppedMembersUpdate {

    public var droppedMembersCount: UInt32
    public var unknownFields: UnknownFields = .init()

    public init(droppedMembersCount: UInt32) {
        self.droppedMembersCount = droppedMembersCount
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupV2MigrationDroppedMembersUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupV2MigrationDroppedMembersUpdate : Hashable {
}
#endif

extension BackupProtoGroupV2MigrationDroppedMembersUpdate : Sendable {
}

extension BackupProtoGroupV2MigrationDroppedMembersUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupV2MigrationDroppedMembersUpdate"
    }

}

extension BackupProtoGroupV2MigrationDroppedMembersUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var droppedMembersCount: UInt32 = 0

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: droppedMembersCount = try protoReader.decode(UInt32.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.droppedMembersCount = droppedMembersCount
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.droppedMembersCount)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupV2MigrationDroppedMembersUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.droppedMembersCount = try container.decode(UInt32.self, forKey: "droppedMembersCount")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || self.droppedMembersCount != 0 {
            try container.encode(self.droppedMembersCount, forKey: "droppedMembersCount")
        }
    }

}
#endif
