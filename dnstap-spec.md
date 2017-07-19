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

# Architecture

There are four logical components in the dnstap system: the encoding format, which specifies how to encode event messages, so called "dnstap payloads"; the transport, which carries serialized event messages over a reliable byte-stream socket; the sender, which generates events using the encoding format and hands them off to the transport; the receiver, which consumes serialized events from the transport, potentially deserializing them using the encoding format.

## Encoding Format

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
