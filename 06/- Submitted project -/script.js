const compRules = {
	"0": "0101010",
	"1": "0111111",
	"-1": "0111010",
	"D": "0001100",
	"A": "0110000",
	"!D" : "0001101",
	"!A" : "0110001",
	"-D": "0001111",
	"-A": "0110011",
	"D+1": "0011111",
	"A+1": "0110111",
	"D-1": "0001110",
	"A-1": "0110010",
	"D+A": "0000010",
	"D-A": "0010011",
	"A-D": "0000111",
	"D&A": "0000000",
	"D|A": "0010101",
	"M": "1110000",
	"!M" : "1110001",
	"-M": "1110011",
	"M+1": "1110111",
	"M-1": "1110010",
	"D+M": "1000010",
	"D-M": "1010011",
	"M-D": "1000111",
	"D&M": "1000000",
	"D|M": "1010101"
}


const destRules = {
	"M": "001",
	"D": "010",
	"MD": "011",
	"A": "100",
	"AM": "101",
	"AD": "110",
	"AMD": "111"
}

const jumpRules = {
	"JGT": "001",
	"JED": "010",
	"JGE": "011",
	"JLT": "100",
	"JNE": "101",
	"JLE": "110",
	"JMP": "111"
}

const preDefinedSymbols = {
	"R0": 0,
	"R1": 1,
	"R2": 2,
	"R3": 3,
	"R4": 4,
	"R5": 5,
	"R6": 6,
	"R7": 7,
	"R8": 8,
	"R9": 9,
	"R10": 10,
	"R11": 11,
	"R12": 12,
	"R13": 13,
	"R14": 14,
	"R15": 15,
	"SCREEN": 16384,
	"KBD": 24576,
	"SP": 0,
	"LCL": 1,
	"ARG": 2,
	"THIS": 3,
	"THAT": 4
}

let labelsAndVariables = {}

document.addEventListener("DOMContentLoaded", () => {
	
	const fileSelector = document.getElementById('file-selector');
	
	fileSelector.addEventListener('change', (event) => {

		const fileList = event.target.files
		const file = fileList[0]
		var reader = new FileReader()

		reader.onload = function(event) {

			let text = reader.result;
			let lines = text.split('\n')
			let linesWithoutComment = []
			let linesWithoutCommentAndWithoutLabels = []

			for (let lineNb = 0; lineNb < lines.length; lineNb++) {
				let line = lines[lineNb]
				let lineWithoutComment = line.split('//')[0]
				let lineTrim = lineWithoutComment.trim();
				if (lineTrim.length > 0) {
					linesWithoutComment.push(lineWithoutComment.trim())
				}
			}

			let lineCounter = 0;
			for (let lineWNb = 0; lineWNb < linesWithoutComment.length; lineWNb++) {
				let line = linesWithoutComment[lineWNb]
				if (line.charAt(0) === '(') {
					let key = line.trim().substring(1).slice(0, -1)
					labelsAndVariables[key] = lineCounter
				} else {
					lineCounter++
					linesWithoutCommentAndWithoutLabels.push(line)
				}
			}

			let memoryCounter = 16
			for (let lineWNb2 = 0; lineWNb2 < linesWithoutCommentAndWithoutLabels.length; lineWNb2++) {
				let line = linesWithoutCommentAndWithoutLabels[lineWNb2]
				if (line.charAt(0) === '@') {
					let destinationStr = line.substring(1).trim()
					if (isNaN(destinationStr) && Object.keys(preDefinedSymbols).indexOf(destinationStr) == -1 && Object.keys(labelsAndVariables).indexOf(destinationStr) == -1) {
						labelsAndVariables[destinationStr] = memoryCounter
						memoryCounter++
					}
				}
			}

			parseLines(linesWithoutCommentAndWithoutLabels);

		}

		reader.readAsText(file)
	})

})

function parseLines(lines) {

	lines.forEach( (line, index) => {

		console.log(index)

		let instructionBinary = ""

		// A instruction (starts with @)
		if (line.charAt(0) === '@') {

			let destinationStr = line.substring(1).trim()

			// Si c'est un nb = on converti la valeur en binaire
			if (!isNaN(destinationStr)) {
				let destinationNb = Number(destinationStr)
				instructionBinary = Number(destinationStr).toString(2).padStart(16,'0')

			// Si c'est pas un nb = variable (todo)
			} else {


				if (Object.keys(preDefinedSymbols).indexOf(destinationStr) !== -1) {
					let symbolDecimal = preDefinedSymbols[destinationStr]
					instructionBinary = symbolDecimal.toString(2).padStart(16,'0')
				} else {
					let symbolDecimal = labelsAndVariables[destinationStr]
					instructionBinary = symbolDecimal.toString(2).padStart(16,'0')
				}

			}

		
		// C instruction
		} else { 

			instructionBinary += "111"


			// 1) comp
			let compAssembly = ""
			if (line.indexOf("=") != -1) {
				compAssembly = line.split("=")[1]
				if (line.indexOf(";") != -1) {
					compAssembly = compAssembly.split(";")[0]
				}
			} else {
				compAssembly = line.split(";")[0]
			}

			let compBinary = compRules[compAssembly.trim()]
			instructionBinary += compBinary


			// 2) dest
			let destAssembly = ""
			let destBinary = ""
			if (line.indexOf("=") === -1) {
				destBinary = "000"
			} else {
				destAssembly = line.split("=")[0]
				destBinary = destRules[destAssembly.trim()]
			}

			instructionBinary += destBinary


			// 3) jump
			let jumpAssembly = ""
			let jumpBinary = ""
			if (line.indexOf(";") === -1) {
				jumpBinary = "000"
			} else {
				let split = line.split(";")
				jumpAssembly = split[split.length-1]
				jumpBinary = jumpRules[jumpAssembly.trim()]
			}

			instructionBinary += jumpBinary

		}

		document.getElementById('result-display').innerHTML += "<br/>"
		document.getElementById('result-display').innerHTML += instructionBinary

	});


}
