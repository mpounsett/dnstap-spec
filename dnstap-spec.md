% Title = "DNSTAP: A Flexible, Binary Log Format for DNS Software"
% abbrev = "DNSTAP Log Format for DNS"
% category = "info"
% docName = "draft-pounsett-dnstab-spec-00"
% ipr = "trust200902"
% area = "OPS"
% workgroup = ""
% keyword = ["dns", "logging"]
%
% date = 2019-03-24T00:00:00Z
%
% [[author]]
% initials = "M."
% surname = "Pounsett"
% fullname = "Matthew Pounsett"
% organization = "Nimbus Operations Inc."
% 	[author.address]
%	email = "matt@conundrum.com"
%   [author.address.postal]
%   city = "Toronto"
%   region = "ON"
%   country = "Canada"
%
% [[author]]
% initials = "M."
% surname = "Kaeo"
% fullname = "Merike Kaeo"
% organization = "Farsight Security"
%   [author.address]
%   email = "merike@doubleshotsecurity.com"
%   [author.address.postal]
%   city = "Seattle"
%   region = "WA"
%   country = "USA"
%

.# Abstract

Abstract paragraphs here.

dnstap is a flexible, structured binary log format for DNS software.  It uses Protocol Buffers to encode events that occur inside DNS software in an implemento-neutral format.  A variety of implementation exist that have been incorporated (or are in the process of getting incorporated) into a variety of DNS operating systems including BIND, KNOT, Unbound and Power DNS.

This work is intended to become an Informational RFC to document the current state of dnstap.

{mainmatter}

# Introduction

dnstap is a flexible, structured binary log format for DNS software.  It uses Protocol Buffers to encode events that occur inside DNS software in an implemento-neutral format.  A variety of implementation exist that have been incorporated (or are in the process of getting incorporated) into a variety of DNS operating systems including BIND, KNOT, Unbound and Power DNS.

This work is intended to become an Informational RFC to document the current state of dnstap.

# Definitions

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "NOT RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [@!RFC2119] [@!RFC8174] when, and only when, they appear in all capitals, as shown here.

DNS terms in this document are used according to the definitions in "DNS Terminology" [@!RFC7719] as updated by [@!I-D.ietf-dnsop-terminology-bis].

# Architecture

There are four logical components in the dnstap system: the encoding format, which specifies how to encode event messages, so called "dnstap payloads"; the transport, which carries serialized event messages over a reliable byte-stream socket; the sender, which generates events using the encoding format and hands them off to the transport; the receiver, which consumes serialized events from the transport, potentially deserializing them using the encoding format.

## Protbuf Message Types

### DNSTAP

### Message

#### Message Fields

##### view

{align=left}
Data Type | Message Types
----------|--------------
bytes | CQ, CR, AQ, AR

In implementations where the operator can configure split DNS (or views), the DNS server SHOULD populate this field with the implementation's identifier for the view that matched the relevant Query.  The field is optional, and implementations which do not support split DNS or are not configured to enable split DNS should omit this field.

The contents of the field are the implementation-dependant identifier for the view.  Implementations SHOULD choose an identifier which is meaningful to the operator.

##### transaction

{align=left}
Data Type | Message Types
----------|--------------
bytes | SQ, SR, CQ, CR, RQ, RR, AQ, AR

When a query is received, name servers SHOULD assign a transaction ID to the message.  When logging the Query message and its corresponding Response, the name server MUST apply that transaction ID to both messages. The same transaction ID name space is shared among all messages types that implement them. Name servers MUST ensure that a transaction ID is unique over a long enough time span to avoid ambiguity in matching Response pairs in a dnstap consumer; it is RECOMMENDED that transaction IDs be generated using a UUID.

### Map

A Map message is written to the protobuf stream to indicate an association between two or more other protobuf messages in the stream.  The association is created by listing the transaction IDs of a related group of DNSTAP messages.  The exact relationship between the messages is dependent on, and must be inferred from, the types of messages involved and their relative positions (or times) in the stream.  

#### Map Fields

##### transaction

{align=left}
Data Type |
----------|
bytes |

The 'transaction' field is a repeated field of type bytes.  Each transaction entry MUST refer to the transaction ID of a protobuf message earlier in the stream.  A Map message MUST have at least two transaction IDs.

The first transaction ID listed MUST be the transaction ID of the DNS message that initiated the mapping.  The order of the second and subsequent transaction IDs in the Map message are defined as having no intrinsic meaning.

#### Examples

##### Example 1

A Client Query arrives at a server with an empty cache.  It is assigned transaction ID 1.  A Recursive Query is sent upstream which is assigned transaction ID 2.  A new Client Query arives which is identical to CQ1, and is assigned transaction ID 3.  Because a related iterative query is already in flight (RQ2) the name server does not initiate a new RQ.  The Recursive Reply paired with RQ2 arrives and is also assigned transaction ID 2.  The CR paired with CQ1 is generated, assigned transaction ID 1, and sent to the client.  The CR paired with CQ3 is also generated, assigned transaction ID 3, and sent to the client.

The following protobuf messages appear in the stream:

{align=left}
F> ~~~~
F> Message type: CQ  transaction: 1
F> Message type: RQ  transaction: 2
F> Map transaction: 1  transaction: 2
F> Message type: CQ  transaction: 3
F> Map transaction: 3  transaction: 2
F> Message type: RR  transaction: 2
F> Message type: CR  transaction: 1
F> Message type: CR  transaction: 3
F> ~~~~

##### Example 2

## Transport

## Event Generator

## Event Consumer


# Security Considerations

A> Add text

# IANA Considerations

A> Add text

{backmatter}

# Document Source

A> [RFC Editor: Please remove this section before publication.]

This document is maintained at Github at
<https://github.com/mpounsett/dnstap-spec>.  Issue reports and pull
requests are gratefully accepted here. 

The XML and TXT versions of this document are generated from Markdown
using mmark by Miek Gieben.  mmark is available at
<https://github.com/miekg/mmark>.

# Changelist

A> [RFC Editor: Please remove this section before publication.]

## Version pounsett-00 (unpublished)

Initial Submission
