<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:for-each select="dictionary/word">
		<xsl:value-of select="translate(./@value, '|', '')"/>

<xsl:text >
	</xsl:text>

		<xsl:choose>
			<xsl:when test="./@sunnySoftRedirection" >
				<xsl:text >ltfont color="black"gtltigt</xsl:text><!-- head word -->
					<xsl:value-of select="translate(./@value, '|', '-')"/>
					<xsl:text >lt/igtlt/fontgt</xsl:text>
				<xsl:if test="./@class" ><!--word class-->
					<xsl:text > ltfont color="orange"gt</xsl:text>
					<xsl:choose>
						<xsl:when test="./@class = 'ab'">adverb</xsl:when>
						<xsl:when test="./@class = 'ie'">infinitival-marker</xsl:when>
						<xsl:when test="./@class = 'in'">interjektion</xsl:when>
						<xsl:when test="./@class = 'jj'">adjective</xsl:when>
						<xsl:when test="./@class = 'kn'">conjunction</xsl:when>
						<xsl:when test="./@class = 'nn'">noun</xsl:when>
						<xsl:when test="./@class = 'pm'">proper-noun</xsl:when>
						<xsl:when test="./@class = 'pn'">personal-and-indefinite-pronoun</xsl:when>
						<xsl:when test="./@class = 'pp'">preposition</xsl:when>
						<xsl:when test="./@class = 'rg'">cardinal-number</xsl:when>
						<xsl:when test="./@class = 'vb'">verb</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="./@class"/>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text >lt/fontgt</xsl:text>
				</xsl:if>

				<xsl:text >
	ltbr/gtltfont color="silver"gtltigtlta href="</xsl:text>
<xsl:value-of select="./@sunnySoftRedirection"/><xsl:text>">》》ltbr/gt</xsl:text>
				<xsl:value-of select="translate(./@sunnySoftRedirection, '|', '-')"/><xsl:text>lt/a></xsl:text>
				<xsl:text >lt/igtlt/fontgt</xsl:text>
			</xsl:when>

			<xsl:otherwise >

		<xsl:text >ltfont color="red"gtltbgt</xsl:text><!-- head word -->
			<xsl:value-of select="translate(./@value, '|', '-')"/>
		<xsl:text >lt/bgtlt/fontgt</xsl:text>

		<xsl:if test="./paradigm/inflection" ><!-- inflection -->
			<xsl:text >ltfont color="darkslategray"gt ltbgt[</xsl:text>
				<xsl:for-each select="./paradigm/inflection">
					<xsl:if test="position()!=1" >, </xsl:if>
					<xsl:value-of select="./@value"/>
				</xsl:for-each>
			<xsl:text >]lt/bgtlt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="./@class" ><!--word class-->
			<xsl:text > ltfont color="orange"gt</xsl:text>
			<xsl:choose>
				<xsl:when test="./@class = 'ab'">adverb</xsl:when>
				<xsl:when test="./@class = 'ie'">infinitival-marker</xsl:when>
				<xsl:when test="./@class = 'in'">interjektion</xsl:when>
				<xsl:when test="./@class = 'jj'">adjective</xsl:when>
				<xsl:when test="./@class = 'kn'">conjunction</xsl:when>
				<xsl:when test="./@class = 'nn'">noun</xsl:when>
				<xsl:when test="./@class = 'pm'">proper-noun</xsl:when>
				<xsl:when test="./@class = 'pn'">personal-and-indefinite-pronoun</xsl:when>
				<xsl:when test="./@class = 'pp'">preposition</xsl:when>
				<xsl:when test="./@class = 'rg'">cardinal-number</xsl:when>
				<xsl:when test="./@class = 'vb'">verb</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="./@class"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text >lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="grammar" ><!--Grammar comment-->
			<xsl:text >ltfont color="silver"gt,lt/fontgt ltfont color="orangered"gt[</xsl:text>
			<xsl:value-of select="grammar/@value"/>
			<xsl:text >]lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@value" ><!--phonemic annotation-->
			<xsl:text >ltbr/gtltfont color="darkcyan"gt/</xsl:text>
			<xsl:value-of select="phonetic/@value"/>
			<xsl:text >/lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@soundFile" ><!-- sound file -->
			<xsl:text >lta href="sound://</xsl:text>
				<xsl:value-of select="translate(substring-before(phonetic/@soundFile, '.swf'), 'àéêÖöÅåÄä', '178339966')"/>
			<xsl:text >.spx">ltimg src="file://beeper.bmp"></xsl:text>
			<xsl:text >ltfont color="silver"gt </xsl:text>
				<xsl:value-of select="substring-before(phonetic/@soundFile, '.swf')"/>
				<xsl:text >.spxlt/fontgt lt/a></xsl:text>
		</xsl:if>

		<!-- begin translation/definition -->
		<xsl:if test="definition">
			<xsl:text >
	ltbr/gtltimg src="sv.bmp"> </xsl:text>
				<xsl:value-of select="definition/@value"/>
			<xsl:if test="definition/translation">
				<xsl:text > ltimg src="uk_small.bmp"> ltfont color="silver"gt</xsl:text>
					<xsl:value-of select="definition/translation/@value"/>
				<xsl:text >lt/fontgt</xsl:text>
			</xsl:if>
		</xsl:if>

		<xsl:text >
	ltbr/gtltimg src="uk.bmp"> ltfont color="silver"gt</xsl:text>
			<xsl:value-of select="translation/@value"/>
		<xsl:text >lt/fontgt</xsl:text>
		<!-- end translation/definition -->

		<!-- begin explanation -->
		<xsl:if test="explanation">
			<xsl:text >
	ltbr/gtltfont color="darkslategray"gtltbgtExplanation: lt/bgtlt/fontgt</xsl:text>
				<xsl:value-of select="explanation/@value"/>
			<xsl:if test="explanation/translation">
				<xsl:text >
	ltbr/gtltimg src="uk_small.bmp"> (</xsl:text>
					<xsl:value-of select="explanation/translation/@value"/>
				<xsl:text >)</xsl:text>
			</xsl:if>
		</xsl:if>
		<!-- end explanation -->

		<xsl:if test="./example" ><!-- example-->
			<xsl:text >ltfont color="silver"gt</xsl:text>
			<xsl:for-each select="./example">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >ltbr/gt•</xsl:text>
					<xsl:value-of select="./@value"/>
				<xsl:text > ltimg src="uk_small.bmp"> </xsl:text>
				<xsl:value-of select="./translation/@value"/>
				<!--<xsl:text >-->
				<!--</xsl:text>-->
			</xsl:for-each>
			<xsl:text >lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="./idiom" ><!-- idiom-->
			<xsl:text >ltbr/gtltbr/gt
	ltfont color="darkslategray"gtltugtIdioms:lt/ugtlt/fontgt
	ltfont color="darkslategray"gt 
			</xsl:text>
			<xsl:for-each select="./idiom">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >ltbr/gtltbgt•</xsl:text>
					<xsl:value-of select="./@value"/>
				<xsl:text >lt/bgt</xsl:text>
				<xsl:text > ltimg src="uk_small.bmp"> </xsl:text>
					<xsl:value-of select="./translation/@value"/>
				<xsl:text >
				</xsl:text>
			</xsl:for-each>
			<xsl:text >lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="./compound" ><!-- compound-->
			<xsl:text >ltbr/gtltbr/gt
	ltfont color="darkslategray"gtltugtCompounds:lt/ugtlt/fontgt
	ltfont color="darkslategray"gt 
			</xsl:text>
			<xsl:for-each select="./compound">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >ltbr/gtltbgt•</xsl:text>
					<xsl:value-of select="translate(./@value, '|', '-')"/>
				<xsl:text >lt/bgt</xsl:text>
				<xsl:text > ltimg src="uk_small.bmp"> </xsl:text>
				<xsl:value-of select="./translation/@value"/>
				<xsl:text ></xsl:text>
			</xsl:for-each>
			<xsl:text >lt/fontgt</xsl:text>
		</xsl:if>

		<xsl:if test="./synonym" ><!-- synonym-->
			<xsl:text >ltbr/gtltbr/gt
	ltfont color="darkslategray"gtltugtSynonyms:lt/ugtlt/fontgt
	ltbr/gtltfont color="darkslategray"gtltbgt </xsl:text>
			<xsl:for-each select="./synonym">
				<xsl:if test="position()!=1" >, </xsl:if>
				<xsl:value-of select="./@value"/>
			</xsl:for-each>
			<xsl:text >lt/bgtlt/fontgt</xsl:text>
		</xsl:if>

	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>
lt/gt
</xsl:text>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
