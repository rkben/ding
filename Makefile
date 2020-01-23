OFILE = style.css
OFILEMIN = style.min.css

default: clean
	cat src/*.css >> $(OFILE)

clean:
	rm -f $(OFILE) $(OFILEMIN)

min: default
	# replace \n and 2 or more spaces
	sed -z 's/\n\| \{2,\}//g' $(OFILE) >> $(OFILEMIN)
	# sub colon+space with just colon
	sed -i 's/: /:/g' $(OFILEMIN)
	# sub comma+space with just comma
	sed -i 's/, /,/g' $(OFILEMIN)
	# sub space+curlyboi with just curlyboi
	sed -i 's/ {/{/g' $(OFILEMIN)

.PHONY: default clean min
