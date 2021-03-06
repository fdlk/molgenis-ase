<#-- modal header -->			
<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	<h4 class="modal-title">ASE variant: ${entity.getString("SNP_ID")}</h4>
</div>

<#-- modal body -->
<div class="modal-body">
	<div class="control-group form-horizontal">		

		<#-- ASE TABLE -->
		<table class="table table-condensed table-striped table-responsive">
			<thead></thead>
			<tbody>
				<tr>
					<th>P_Value</th>
					<td><#if entity.get("P_Value") == 0>&le; 2E-311<#else>${entity.get("P_Value")?string("0.##E0")}</#if></td>
					<th>Chromosome</th>
					<td>${entity.getString("Chr")}</td>
					<th>SNP_ID</th>
					<td>
						<#if entity.getString("SNP_ID")?starts_with("rs")>
							<a target="_blank" href="http://identifiers.org/dbsnp/${entity.get("SNP_ID")}">${entity.get("SNP_ID")}</a>
						<#else>
							${entity.getString("SNP_ID")}
						</#if>
					</td>
				</tr>
				<tr>
					<th>Likelihood_ratio_test_D</th>
					<td>${entity.get("Likelihood_ratio_test_D")?string("0.##E0")}</td>
					<th>Position</th>
					<td>${entity.getString("Pos")}</td>
					<th>Reference_allele</th>
					<td>${entity.getString("Reference_allele")}</td>
				</tr>
				<tr>
					<th>Fraction_alternative_allele</th>
					<td>${entity.getString("Fraction_alternative_allele")}</td>
					
					<th>Samples</th>
					<td>${entity.getString("Samples")}</td>
					<th>Alternative_allele</th>
					<td>${entity.getString("Alternative_allele")}</td>
				</tr>
			</tbody>
		</table>
		
		<#-- GENE TABLE -->
		<#if entity.getEntities("Genes")?has_content>
			<table class="table table-condensed table-striped table-responsive">
				<thead>
					<#list  entity.getEntities("Genes")?first.getAttributeNames() as attribute>
						<th>${attribute}</th>
					</#list>
				</thead>
				<tbody>
					<#list entity.getEntities("Genes") as gene>
						<tr>
						<#list gene.getAttributeNames() as attribute>
							<#if attribute == "Ensembl_ID">
								
								<td>
									<a target="_blank" href="http://identifiers.org/ensembl/${gene.getString(attribute)}">${gene.getString(attribute)}</a>
								</td>
							<#else>
								<td>${gene.getString(attribute)}</td>
							</#if>	
						</#list>
						</tr>
					</#list>
				</tbody>
			</table>
		</#if>
		
		<#-- Image here -->
		<div id="AseImage">
			<#assign link = entity.getString("SNP_ID")?replace(":", "_")>
			<img src="https://molgenis26.target.rug.nl/downloads/publicRnaSeq/asePlots/png/${link}.png"><img>
		</div>
		
		<hr></hr>
		
		<#-- Download buttons -->
		<button type="button" class="btn" data-href="/menu/main/dataexplorer/details/csv">Download ASE sample table</button>
		<button type="button" class="btn" data-href="https://molgenis26.target.rug.nl/downloads/publicRnaSeq/asePlots/pdf/${link}.pdf">Download PDF version of ASE graph</button>
		
		<hr></hr>
		
		<#-- Genomebrowser here -->
		<div id="modalGenomeBrowser"></div>
	</div>
</div>
	
<#-- modal footer -->
<div class="modal-footer">
	<button type="button" class="btn btn-default" data-dismiss="modal">close</button>
</div>

<script>
	molgenis.dataexplorer.data.createGenomeBrowser({
		pageName: 'modalGenomeBrowser', 
		noPersist: true, chr: ${entity.getString("Chr")}, 
		viewStart: ${entity.getString("Pos")} - 10000, 
		viewEnd: ${entity.getString("Pos")} + 10000,
		disableDefaultFeaturePopup: true
	});
	
	setTimeout(function(){
		$('.modal-body').animate({scrollTop:0},0);
	}, 10);
</script>	