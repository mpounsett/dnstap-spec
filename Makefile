mmark=mmark
xml2rfc=xml2rfc

all: txt html

xml: dnstap-spec.xml

html: dnstap-spec.html

txt: dnstap-spec.txt

dnstap-spec.xml: dnstap-spec.md
	$(mmark) -page -xml2 dnstap-spec.md > dnstap-spec.xml

dnstap-spec.html: dnstap-spec.xml
	$(xml2rfc) --html dnstap-spec.xml

dnstap-spec.txt: dnstap-spec.xml
	$(xml2rfc) --text dnstap-spec.xml

clean:
	rm -f dnstap-spec.{txt,html,xml}
