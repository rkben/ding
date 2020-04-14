OFILE = style.css
OFILEMIN = style.min.css
#CSS = $(foreach dir,src,$(wildcard $(dir)/*.css))

ifeq ($(USECONF), yes)
	include config.mk
endif

default: clean
	cat src/*.css >> $(OFILE)

minify: clean
	@# strip comments
	sed 's/\/\*.*\*\///g' src/*.css >> $(OFILEMIN)
	@# replace \n and 2 or more spaces
	sed -zi 's/\n\| \{2,\}//g' $(OFILEMIN)
	@# sub colon+space with just colon
	sed -i 's/: /:/g' $(OFILEMIN)
	@# sub comma+space with just comma
	sed -i 's/, /,/g' $(OFILEMIN)
	@# sub space+curlyboi with just curlyboi
	sed -i 's/ {/{/g' $(OFILEMIN)
	@# sub curlyboi+space with just curlyboi
	sed -i 's/ }/}/g' $(OFILEMIN)
	@# sub semi-colon+space
	sed -i 's/; /;/g' $(OFILEMIN)

clean:
	rm -f $(OFILE) $(OFILEMIN)

all: clean default minify

.PHONY: default minify clean all
