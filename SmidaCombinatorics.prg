' Combinatorics: Arrangements, Permutations, and Combinations.
'' EViews program for generating and displaying all possible arrangements, permutations, and combinations.
''' Add-in written by : SMIDA Houcine L. 2026.
' ------------------------------------------------------------------
' dialog box options 
' ------------------------------------------------------------------
%list = "1 2 3 4"
!type = 1
%typelist = " "" 1. Arrangement / Permutation ""  "" 2. Combination "" "
%k="2"
!result = @uidialog("caption", "Combinatorics : Arrangement - Permutation - Combination", _
"edit", %list, "Enter a list of n distinct elements, separated by spaces (e.g., 1 2 3 4, A B C D, Blue Green Red Yellow), where n is the number of entered elements", 100000, _
"text", "Enclose text strings in double-quotes “” ", _
"edit", %k, "Enter the value of k (1<=k<=n), where k is the number of elements selected from the set of n distinct elements", 2, _
"radio", !type, "Select a method", %typelist , _
"text", "EViews program for generating all arrangements, permutations, and combinations", _
 "text", "Add-in written by : SMIDA Houcine L. 2026") 
' ------------------------------------------------------------------
' stop if the Cancel button is clicked 
' ------------------------------------------------------------------
if !result = -1 then
	stop
endif
' ------------------------------------------------------------------
' display a warning if the list is empty when OK is clicked 
' ------------------------------------------------------------------
if @wcount(%list) < 1 and !result <> -1 then
	@uiprompt("The list is empty. Please enter a list of n distinct elements to continue")
	return
endif
' ------------------------------------------------------------------
' use "NA" as temporary variables
' ------------------------------------------------------------------
for !i= 1 to @wcount(%list)
	if @word(%list,!i)="NA" or @word(%list,!i)="na" or @word(%list,!i)="Na" or @word(%list,!i)="nA" then
		@uiprompt("Please do not use the string ""NA"" ")
		return
	endif
next
' ------------------------------------------------------------------
' enter distinct elements (without repetition)
' ------------------------------------------------------------------
for !i= 1 to @wcount(%list) -1
	for !j= !i+1 to @wcount(%list)
		if @word(%list,!i)=@word(%list,!j) then
			@uiprompt("Please enter distinct elements (without repetition)")
			return
		endif
	next
next
' ------------------------------------------------------------------
' maximum number of elements that can be "permuted"
' ------------------------------------------------------------------
if !type = 1 then 
	if @wcount(%list)=@val(%k) and @wcount(%list) > 10 and !result <> -1 then
		@uiprompt("A maximum of 10 distinct elements can be permuted")
		return
	endif
endif
' ------------------------------------------------------------------
' for arrangements and combinations without repetition, the limits depend on n and k, particularly on the value of k relative to n.
' for arrangements without repetition, when n is fixed, the number of possible arrangements is increasing with k and attains its maximum for k=n-1 and k=n.
' for combinations without repetition, the number of possible combinations is maximal at k=n/2 when n is even, and at k=(n-1)/2 and k=(n + 1)/2 when n is odd.
' ------------------------------------------------------------------
' conditions on k
' ------------------------------------------------------------------
if @val(%k)=NA or @val(%k)<1 or @val(%k)>@wcount(%list) and !result <> -1 then
	@uiprompt("Enter a value of k (1<=k<=n) ", "O")
	return
endif
' ------------------------------------------------------------------
' set the values of n and k
' ------------------------------------------------------------------
!n=@wcount(%list)
!k=@val(%k)
!h=!n-!k
' ------------------------------------------------------------------
!n1=!n-1
' ------------------------------------------------------------------
!factorial=@fact(!n)									' factorial
!arrangement=@fact(!n)/(@fact(!n-!k))			' arrangement
!combination=@fact(!n)/(@fact(!k)*@fact(!n-!k))	' combination
!permutation=@fact(!n)								' permutation
' ------------------------------------------------------------------
' create workfile  
' ------------------------------------------------------------------
workfile Combinatorics u 1 !n
' ------------------------------------------------------------------
table Tab0
table Tab
' ------------------------------------------------------------------
' define the table 
' ------------------------------------------------------------------
if !h>0 then
	for !i=1 to !h 
		Tab0(!i)="NA"	
	next
endif
' ------------------------------------------------------------------
for !i=1 to !n
	Tab(!i)=@word(%list,!i)
next
' ------------------------------------------------------------------
' set the column width for the final results table
' ------------------------------------------------------------------
for !i=1 to !n  
	!colwidthi=@length(Tab(!i))
!maxcolwidth=@length(Tab(1))
	if !colwidthi>!maxcolwidth then
		!maxcolwidth=!colwidthi
	endif
next
!colwidth=!maxcolwidth+2
' ------------------------------------------------------------------
' 1. Arrangement / Permutation
' ------------------------------------------------------------------
' subroutine SmidaArr
' ------------------------------------------------------------------
subroutine  SmidaArr(table E, scalar !g, scalar !k) 
' ------------------------------------------------------------------
	if !g<=!h then
		return
	endif
	!g=!h+1
	while !g<=@wcount(%list)
		table F=E	
		for !i=1 to !g  
			table B=F   ' or B!i
			B.insertrow(!i) 1
			for !j=1 to @fact(!g-1)/(@fact(!h))  
				B(!i,!j)=Tab(!g-!h)    
			next
			tabplace(E,B, 1, (@fact(!g-1)/(@fact(!h)))*(!i-1)+1, 1, 1, @fact(!g)/(@fact(!h)), @fact(!g)/(@fact(!h)))
			d B
		next
		d F
		!g=!g+1
	wend
endsub
' ------------------------------------------------------------------
' end subroutine SmidaArr
' ------------------------------------------------------------------
' 2. Combination
' ------------------------------------------------------------------
' subroutine SmidaComb
' ------------------------------------------------------------------
subroutine SmidaComb(table E, scalar !g, scalar !k) 
' ------------------------------------------------------------------
	if !g<=!h then
		return
	endif
	!g=!h+1
	table F=E
	for !i=1 to !g  
		table B=F 
		B.insertrow(!i) 1
		for !j=1 to @fact(!g-1)/(@fact(!h))  
			B(!i,!j)=Tab(!i)
		next
		tabplace(E,B, 1, (@fact(!g-1)/(@fact(!h)))*(!i-1)+1, 1, 1, @fact(!g)/(@fact(!h)), @fact(!g)/(@fact(!h)))
		d B
	next
	d F
' ------------------------------------------------------------------
	!g=!h+1
	while !g<=!n1
		table F=E 	
		for !i=!g-!h to !g  
			!ci=@fact(!i)/(@fact(!g-!h)*@fact(!i-!g+!h))
			table B=F
			table A
			B.copyrange 1 1 !i !ci  A 1 1 
			A.insertrow(!i+1) 1 
			for !j=1 to !ci
				A(!i+1,!j)=Tab(!i+1)
				for !t=!i+2 to !g+1
					A(!t,!j)="NA"
				next
			next
' ------------------------------------------------------------------
			!k=!g-!h
			if !i=!k then	
				tabplace(E, A, 1, 1, 1, 1, !g+1, !ci)
			else
				!c2=@fact(!i)/(@fact(!g-!h+1)*@fact(!i-!g+!h-1))+1 
				tabplace(E, A, 1, !c2, 1, 1, !g+1, !ci)
			endif
			d B
			d A
		next
		d F
		!g=!g+1
	wend
endsub
' ------------------------------------------------------------------
' end subroutine SmidaComb
' ------------------------------------------------------------------
if !type = 1 then
	call SmidaArr(Tab0, !n, !k)
	if !k=@wcount(%list) then
		table TabPermutation=Tab0
		TabPermutation.setwidth(@all) !colwidth
		show TabPermutation ' display result
	endif
	table TabArrangement
	table Tab1
	for !j=1 to !arrangement
		table Tab2
		Tab0.copyrange 1 !j !n !j Tab2 1 1
		Tab2.insertcol(2) 1
		for !t=1 to !n-1
			Tab2(!t,2)=!t 
		next
		Tab2.sort(a1:b!n) a
		for !t=1 to !n-1
			if Tab2(!t,1)="NA" then
				Tab2.deleterow(!t)
			endif
		next
		tabplace(Tab1,Tab2, 1, !j, 1, 2, !k-1, !j)
	next
	for !i=1 to !k
		for !j=1 to !arrangement 
			TabArrangement(!i,!j)=Tab(@val(Tab1(!k-!i+1,!j)))
		next
	next
	TabArrangement.setwidth(@all) !colwidth
	show TabArrangement ' display result
	d Tab
	d Tab0
	d Tab1
	d Tab2
endif
' ------------------------------------------------------------------
if !type = 2 then
	call SmidaComb(Tab0, !n, !k+1)
	table TabCombination
	table Tab1
	for !j=1 to !combination
		table Tab2
		Tab0.copyrange 1 !j !n !j Tab2 1 1
		Tab2.insertcol(2) 1
		for !t=1 to !n
			Tab2(!t,2)=!t 
		next
		Tab2.sort(a1:b!n) a
		for !l=1 to !h
			for !t=1 to !n
				if Tab2(!t,1)="NA" then
					Tab2.deleterow(!t)
				endif
			next
		next
		tabplace(Tab1,Tab2, 1, !j, 1, 2, !k, !j)
	next
	for !i=1 to !k
		for !j=1 to !combination 
			TabCombination(!i,!j)=Tab(@val(Tab1(!i,!j)))
		next
	next
	d Tab
	d Tab0
	d Tab1
	d Tab2
	TabCombination.setwidth(@all) !colwidth
	show TabCombination ' display result
endif
' ------------------------------------------------------------------
' End program
' ------------------------------------------------------------------


