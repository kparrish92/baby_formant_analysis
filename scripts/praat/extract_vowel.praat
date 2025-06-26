####################################
# Praat script to extract values   #
# Created by                       #
# Kyle Parrish 06/24/2025          #
#                                  #
# This file will:                  #
#  - extract f1, f2 and f3         #
#  - save output to ./data dir     #
####################################


#
# Set some parameters ---------------------------------------------------
#


# Where to save data
outputDir$ = "../../data/"

# Choose name for .csv file
outFile$ = "formants.csv"

# Where are the .wav and textgrid files located?
filePath$ = "../../sound_files/CoartCondition/"

# -----------------------------------------------------------------------

#
# Set up data file ------------------------------------------------------
#

# Delete current file if it exists
filedelete 'outputDir$'/'outFile$'

# Create newfile with header
fileappend 'outputDir$'/'outFile$' fileID,f1,f2,f3,duration'newline$'

# -----------------------------------------------------------------------




#
# Prepare loop ----------------------------------------------------------
#

Create Strings as file list... dirFiles 'filePath$'/*.wav
select Strings dirFiles
numberOfFiles = Get number of strings

# -----------------------------------------------------------------------


#
# Start loop ------------------------------------------------------------
#

for file to numberOfFiles
	select Strings dirFiles
	fileName$ = Get string: file
	prefix$ = fileName$ - ".wav"
	Read from file... 'filePath$'/'prefix$'.wav
	Read from file... 'filePath$'/'prefix$'.TextGrid
	labels = Count labels: 3, "exclude"
	labID$ = Get label of interval: 3, 1

	if labels = 0

		# Calculate mid-point of vowel 
		vowelStart = Get start point: 3, 9
		vowelEnd  = Get end point: 3, 9
		durationV =  vowelEnd - vowelStart
		mp = vowelStart + (durationV * 0.50)

		# Get formants
		select Sound 'prefix$'
		do ("To Formant (burg)...", 0, 5, 5500, 0.025, 50)
		f1 = do ("Get value at time...", 1, mp, "Hertz", "Linear")
		f2 = do ("Get value at time...", 2, mp, "Hertz", "Linear")
		f3 = do ("Get value at time...", 3, mp, "Hertz", "Linear")

	endif

	# Append data to output 
	fileappend 'outputDir$'/formants.csv 'prefix$','f1:2','f2:2','f3:2','durationV', 'vowelStart', 'vowelEnd', 'mp', 'newline$'
	# Printline for bug fixes
	printline 'f1:2','f2:2','f3:2' 'durationV', 'vowelStart', 'vowelEnd', 'mp'


	# Clean up
	select all
	minus Strings dirFiles
	Remove
	endif
endfor

# -----------------------------------------------------------------------


# Clean up
select all
Remove
