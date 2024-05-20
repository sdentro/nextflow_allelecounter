
include { runAlleleCounter } from '../modules/alleleCounter'
include { packageAlleleCounterOutput } from '../modules/alleleCounter'

workflow alleleCounter {
	Channel.fromPath(params.chromosomes)
		.splitText()
        	.map { it.replaceFirst(/\n/,'') }
        	.set { chrom_list }

	af_ch = runAlleleCounter(params.samplename, params.bam, params.bai, params.loci, params.output, chrom_list)
	pack_ch = packageAlleleCounterOutput(params.samplename, af_ch.collect())
	pack_ch.view()
}
