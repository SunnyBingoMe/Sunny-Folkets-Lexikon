<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">
	<xsl:text >#NAME "Sunny Folkets Lexikon SV-EN/SV </xsl:text> 
	<xsl:value-of select="$type"/>
	<xsl:text>(BugTo: BinSun@mail.com)"
#INDEX_LANGUAGE "Swedish"
#CONTENTS_LANGUAGE "Swedish"

</xsl:text>

	<xsl:for-each select="dictionary/word">
		<xsl:value-of select="translate(./@value, '|', '')"/>

<xsl:text >
	</xsl:text>

		<xsl:choose>
			<xsl:when test="./@sunnySoftRedirection" >
				<xsl:text >[m0][c black][i]</xsl:text><!-- head word -->
					<xsl:value-of select="translate(./@value, '|', '-')"/>
				<xsl:text >[/i][/c]</xsl:text>
				<xsl:if test="./@class" ><!--word class-->
					<xsl:text > [c orange]</xsl:text>
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
					<xsl:text >[/c]</xsl:text>
				</xsl:if>

				<xsl:text >
			[m1][c grey][i]》》</xsl:text>
				<xsl:value-of select="./@sunnySoftRedirection"/>
				<xsl:text >[/i][/c][/m]</xsl:text>
			</xsl:when>

			<xsl:otherwise >

		<xsl:text >[m0][c red][b]</xsl:text><!-- head word -->
			<xsl:value-of select="translate(./@value, '|', '-')"/>
		<xsl:text >[/b][/c]</xsl:text>

		<xsl:if test="./paradigm/inflection" ><!-- inflection -->
			<xsl:text >[c darkslategray] [b]\[</xsl:text>
				<xsl:for-each select="./paradigm/inflection">
					<xsl:if test="position()!=1" >, </xsl:if>
					<xsl:value-of select="./@value"/>
				</xsl:for-each>
			<xsl:text >\][/b][/c]</xsl:text>
		</xsl:if>

		<xsl:if test="./@class" ><!--word class-->
			<xsl:text > [c orange]</xsl:text>
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
			<xsl:text >[/c]</xsl:text>
		</xsl:if>

		<xsl:if test="grammar" ><!--Grammar comment-->
			<xsl:text >[c grey],[/c] [c orangered]\[</xsl:text>
			<xsl:value-of select="grammar/@value"/>
			<xsl:text >\][/c]</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@value" ><!--phonemic annotation-->
			<xsl:text > [c darkcyan]\/</xsl:text>
			<xsl:value-of select="phonetic/@value"/>
			<xsl:text >\/[/c]</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@soundFile" ><!-- sound file -->
			<xsl:text >[s]</xsl:text>
				<xsl:value-of select="translate(substring-before(phonetic/@soundFile, '.swf'), 'àéêÖöÅåÄä', '1783399==')"/>
			<xsl:text >.</xsl:text><xsl:value-of select="$type"/><xsl:text >[/s]</xsl:text>
			<xsl:text >[c grey]</xsl:text>
				<xsl:value-of select="substring-before(phonetic/@soundFile, '.swf')"/>
			<xsl:text >.</xsl:text><xsl:value-of select="$type"/><xsl:text >[/c]</xsl:text>
			<xsl:text >[/m]</xsl:text><!-- m0 -->
		</xsl:if>

		<!-- begin translation/definition -->
		<xsl:text >
			[m1][s]uk.bmp[/s] </xsl:text>
			<xsl:value-of select="translation/@value"/>
		<xsl:text >[/m]</xsl:text>

		<xsl:if test="definition">
			<xsl:text >
				[m1][s]sv.bmp[/s] </xsl:text>
				<xsl:value-of select="definition/@value"/>
			<xsl:text >[/m]</xsl:text>
			<xsl:if test="definition/translation">
				<xsl:text >
					[m2][s]uk_small.bmp[/s] (</xsl:text>
					<xsl:value-of select="definition/translation/@value"/>
				<xsl:text >)[/m]</xsl:text>
			</xsl:if>
		</xsl:if>
		<!-- end translation/definition -->

		<!-- begin explanation -->
		<xsl:if test="explanation">
			<xsl:text >
				[m1][c darkslategray][b]Explanation: [/b][/c]</xsl:text>
				<xsl:value-of select="explanation/@value"/>
			<xsl:text >[/m]</xsl:text>
			<xsl:if test="explanation/translation">
				<xsl:text >
					[m2][s]uk_small.bmp[/s] (</xsl:text>
					<xsl:value-of select="explanation/translation/@value"/>
				<xsl:text >)[/m]</xsl:text>
			</xsl:if>
		</xsl:if>
		<!-- end explanation -->

		<xsl:if test="./example" ><!-- example-->
			<xsl:for-each select="./example">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >[m2][ex][*]•[/*][/ex][c darkgray] [/c][ex][*]{{x}}</xsl:text>
					<xsl:value-of select="./@value"/>
				<xsl:text > [s]uk_small.bmp[/s] </xsl:text>
				<xsl:value-of select="./translation/@value"/>
				<xsl:text >{{/x}} [/*][/ex]
				</xsl:text>
			</xsl:for-each>
		</xsl:if>

		<xsl:if test="./idiom" ><!-- idiom-->
			<xsl:text >[m3][c white]_______[/c][/m]
				{{Idiom}}[m3][c darkslategray][u]Idioms:[/u][/c]
				[c darkslategray] 
			</xsl:text>
			<xsl:for-each select="./idiom">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >[m4][b]</xsl:text>
					<xsl:value-of select="./@value"/>
				<xsl:text >[/b]</xsl:text>
				<xsl:text > [s]uk_small.bmp[/s] </xsl:text>
					<xsl:value-of select="./translation/@value"/>
				<xsl:text >
				</xsl:text>
			</xsl:for-each>
			<xsl:text >[/c]</xsl:text>
		</xsl:if>

		<xsl:if test="./compound" ><!-- compound-->
			<xsl:text >[m3][c white]_______[/c][/m]
				{{Compound}}[m3][c darkslategray][u]Compounds:[/u][/c]
				[c darkslategray] 
			</xsl:text>
			<xsl:for-each select="./compound">
				<xsl:if test="position()!=1" >
				</xsl:if>
				<xsl:text >[m4][b]</xsl:text>
					<xsl:value-of select="translate(./@value, '|', '-')"/>
				<xsl:text >[/b]</xsl:text>
				<xsl:text > [s]uk_small.bmp[/s] </xsl:text>
				<xsl:value-of select="./translation/@value"/>
				<xsl:text ></xsl:text>
			</xsl:for-each>
			<xsl:text >[/c]</xsl:text>
		</xsl:if>

		<xsl:if test="./synonym" ><!-- synonym-->
			<xsl:text >[m3][c white]_______[/c][/m]
				{{Synonyms}}[m3][c darkslategray][u]Synonyms:[/u][/c]
				[m4][c darkslategray][b] </xsl:text>
			<xsl:for-each select="./synonym">
				<xsl:if test="position()!=1" >, </xsl:if>
				<xsl:value-of select="./@value"/>
			</xsl:for-each>
			<xsl:text >[/b][/c]</xsl:text>
		</xsl:if>

	</xsl:otherwise>
	</xsl:choose>
<xsl:text >

</xsl:text>

	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
