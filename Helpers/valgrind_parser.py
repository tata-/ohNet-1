import xml.etree.ElementTree as ET
import os

class valgrindParser():
	def get_files(self,dir):
		dir_list = os.listdir(dir)
		
		file_list = []

		for f_name in dir_list:
			file = os.path.join(dir,f_name)
			file_list.append(file)

		self.file_list = file_list

	def parse_file(self):
		for file in self.file_list:
			doc = ET.parse(file)
			errors = doc.findall('//error')
			out = open(file,"w")
			out.write('<?xml version="1.0" encoding="UTF-8"?>\n')
			out.write('<testsuite name="memcheck" tests="1" errors="0" failures="'+str(len(errors))+'" skip="0">\n')
			out.write('    <testcase classname="ValgrindMemoryCheck " \n')
			out.write('              name="'+file+'" time="0">\n')

			for error in errors:
				kind = error.find('kind')
				what = error.find('what')
				if  what == None:
					what = error.find('xwhat/text')
				out.write('        <error type="'+kind.text+'">\n')
				out.write('            '+what.text+'\n')

				frames = error.findall('.//frame')

				for frame in frames:
					getObj = frame.find('ip')
					getFn = frame.find('fn')
					getDir = frame.find('dir')
					getFile = frame.find('file')
					getLine = frame.find('line')
				
					out.write(' ---- frame start ----\n')
					if getObj != None:
						obj = StripChars(getObj.text)
						out.write(' Object: '+obj+'\n')

					if getFn != None:
						function = StripChars(getFn.text)
						out.write(' Function: '+function+'\n')
					if getDir != None:
						dir = StripChars(getDir.text)
						out.write(' Directory: '+dir+'\n')
					if getFile != None:
						file = StripChars(getFile.text)
						out.write(' File: '+file+'\n')
					if getLine != None:
						line = StripChars(getLine.text)
						out.write(' Line: '+line+'\n')
				out.write(' ---- frame end ----\n')
				
				out.write('        </error>\n')
			out.write('    </testcase>\n')	
			out.write('</testsuite>\n')
			out.close()

def main():
	val = valgrindParser()
	val.get_files('vgout')
	val.parse_file()

if "__name__" == "__main__":
	main()
