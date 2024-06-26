//
// Copyright 2024 Signal Messenger, LLC
// SPDX-License-Identifier: AGPL-3.0-only
//

// Code generated by Wire protocol buffer compiler, do not edit.
// Source: BackupProto.BackupProtoGroupSequenceOfRequestsAndCancelsUpdate in Backup.proto
import Foundation
import Wire

/**
 * A single requestor has requested to join and cancelled
 * their request repeatedly with no other updates in between.
 * The last action encompassed by this update is always a
 * cancellation; if there was another open request immediately
 * after, it will be a separate GroupJoinRequestUpdate, either
 * in the same frame or in a subsequent frame.
 */
public struct BackupProtoGroupSequenceOfRequestsAndCancelsUpdate {

    public var requestorAci: Foundation.Data
    public var count: UInt32
    public var unknownFields: UnknownFields = .init()

    public init(requestorAci: Foundation.Data, count: UInt32) {
        self.requestorAci = requestorAci
        self.count = count
    }

}

#if !WIRE_REMOVE_EQUATABLE
extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : Equatable {
}
#endif

#if !WIRE_REMOVE_HASHABLE
extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : Hashable {
}
#endif

extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : Sendable {
}

extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : ProtoMessage {

    public static func protoMessageTypeURL() -> String {
        return "type.googleapis.com/BackupProto.BackupProtoGroupSequenceOfRequestsAndCancelsUpdate"
    }

}

extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : Proto3Codable {

    public init(from protoReader: ProtoReader) throws {
        var requestorAci: Foundation.Data = .init()
        var count: UInt32 = 0

        let token = try protoReader.beginMessage()
        while let tag = try protoReader.nextTag(token: token) {
            switch tag {
            case 1: requestorAci = try protoReader.decode(Foundation.Data.self)
            case 2: count = try protoReader.decode(UInt32.self)
            default: try protoReader.readUnknownField(tag: tag)
            }
        }
        self.unknownFields = try protoReader.endMessage(token: token)

        self.requestorAci = requestorAci
        self.count = count
    }

    public func encode(to protoWriter: ProtoWriter) throws {
        try protoWriter.encode(tag: 1, value: self.requestorAci)
        try protoWriter.encode(tag: 2, value: self.count)
        try protoWriter.writeUnknownFields(unknownFields)
    }

}

#if !WIRE_REMOVE_CODABLE
extension BackupProtoGroupSequenceOfRequestsAndCancelsUpdate : Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StringLiteralCodingKeys.self)
        self.requestorAci = try container.decode(stringEncoded: Foundation.Data.self, forKey: "requestorAci")
        self.count = try container.decode(UInt32.self, forKey: "count")
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: StringLiteralCodingKeys.self)
        let includeDefaults = encoder.protoDefaultValuesEncodingStrategy == .include

        if includeDefaults || !self.requestorAci.isEmpty {
            try container.encode(stringEncoded: self.requestorAci, forKey: "requestorAci")
        }
        if includeDefaults || self.count != 0 {
            try container.encode(self.count, forKey: "count")
        }
    }

}
#endif
