
process runAlleleCounter {
	label 'singlecpu_medmem_lowtime'

	input:
		val samplename
		path bam
		path bai
		path loci
		val output
		val chrom

	output:
		file ("alleleFrequencies/*.txt")

	"""
	mkdir alleleFrequencies
	alleleCounter --dense-snps -b $bam -l ${loci}/1000genomesloci2012_chr${chrom}.txt -o alleleFrequencies/${output}${chrom}.txt
	"""
}

process packageAlleleCounterOutput {
	label 'singlecpu_lowmem_lowtime'

	publishDir "${baseDir}", mode: 'copy'

	input:
		val samplename
		path input

	output:
		file 'alleleCounter/*.gz'

	"""
	mkdir alleleCounter
	tar czfh alleleCounter/${samplename}_alleleFrequencies.tar.gz ${input}
	"""
}
