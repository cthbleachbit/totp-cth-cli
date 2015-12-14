convertBy5Bit () {
	local input5Bit	
	input5Bit=${1:0:1}
	local outputBinary
	case $1 in
		A|a|=)	outputBinary='00000';;
		B|b)	outputBinary='00001';;
		C|c)	outputBinary='00010';;
		D|d)	outputBinary='00011';;
		E|e)	outputBinary='00100';;
		F|f)	outputBinary='00101';;
		G|g)	outputBinary='00110';;
		H|h)	outputBinary='00111';;
		I|i)	outputBinary='01000';;
		J|j)	outputBinary='01001';;
		K|k)	outputBinary='01010';;
		L|l)	outputBinary='01011';;
		M|m)	outputBinary='01100';;
		N|n)	outputBinary='01101';;
		O|o)	outputBinary='01110';;
		P|p)	outputBinary='01111';;
		Q|q)	outputBinary='10000';;
		R|r)	outputBinary='10001';;
		S|d)	outputBinary='10010';;
		T|t)	outputBinary='10011';;
		U|u)	outputBinary='10100';;
		V|v)	outputBinary='10101';;
		W|w)	outputBinary='10110';;
		X|x)	outputBinary='10111';;
		Y|y)	outputBinary='11000';;
		Z|z)	outputBinary='11001';;
		2)	outputBinary='11010';;
		3)	outputBinary='11011';;
		4)	outputBinary='11100';;
		5)	outputBinary='11101';;
		6)	outputBinary='11110';;
		7)	outputBinary='11111';;
	esac
	echo -n ${outputBinary}
}

convertBy40Bit () {
	local input40Bit
	input40Bit="$1"
	for (( i=${#input40Bit}+1; i<=5; i++ )); do
		input40Bit=${input40Bit}"="
	done
	
	local output40BitBinary
	for (( i=0; i<5; i++)); do
		output40BitBinary="${output40BitBinary}`convertBy5Bit ${input40Bit:${i}:1}`"
	done
	echo -n ${output40BitBinary}
} 

decodeBase32 () {
	local outputBinaryCode
	input=$1
	for (( i=0; i<${#input}; i=${i}+5)); do
		outputBinaryCode="${outputBinaryCode}`convertBy40Bit ${input:${i}:5}`"
	done
	echo -n ${outputBinaryCode}
}

base32ToHex () {
	local binCode
	binCode=`decodeBase32 $1`
	local hexBuffer
	for (( i=${#binCode}-4; i>=0; i=i-4)); do
		hexBuffer=$((2#${binCode:$[i]:4}))"${hexBuffer}"
	done 
	echo "obase=16;${hexBuffer}" | bc
}

base32ToDec () {
	binCode=`decodeBase32 $1`
	echo -n $((2#${binCode}))
}

base32ToString () {
	local hexCode
	hexCode=`base32ToHex $1`
	for (( i=0; i<${#hexCode}; i=i+2)); do
		stringBuffer=${stringBuffer}"\x${hexCode:i:2}"
	done
	printf "%b" "$stringBuffer"
}

