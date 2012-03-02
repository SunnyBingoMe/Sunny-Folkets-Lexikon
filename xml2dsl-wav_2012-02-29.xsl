<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text"/>

<xsl:template match="/">
<xsl:text >#NAME "Sunny Folkets sv_en (bug: BinSun@mail.com)"
#INDEX_LANGUAGE "Swedish"
#CONTENTS_LANGUAGE "English"

</xsl:text>

	<xsl:for-each select="dictionary/word">
		<xsl:value-of select="translate(./@value, '|', '')"/>

<xsl:text >
	</xsl:text>

		<xsl:text >[c red][b]</xsl:text><!-- head word -->
			<xsl:value-of select="translate(./@value, '|', '·')"/>
		<xsl:text >[/b][/c]</xsl:text>

		<xsl:if test="./paradigm/inflection" ><!-- inflection -->
			<xsl:text >[c darkslategray] [b]\[</xsl:text>
				<xsl:for-each select="./paradigm/inflection">
					<xsl:if test="position()!=1" >, </xsl:if>
					<xsl:value-of select="./@value"/>
				</xsl:for-each>
			<xsl:text >\][/b][/c]</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@value" ><!-- phonemic annotation -->
			<xsl:text > [c green]\/</xsl:text>
			<xsl:value-of select="phonetic/@value"/>
			<xsl:text >\/[/c][/m]</xsl:text>
		</xsl:if>

		<xsl:if test="phonetic/@soundFile" ><!-- sound file -->
			<xsl:text > [s]</xsl:text><xsl:value-of select="substring-before(phonetic/@soundFile, '.swf')"/><xsl:text >.wav[/s]</xsl:text>
			<xsl:text >[c grey]</xsl:text><xsl:value-of select="substring-before(phonetic/@soundFile, '.swf')"/><xsl:text >.wav[/c]</xsl:text>
			<xsl:text >[/m]</xsl:text>
		</xsl:if>

<xsl:text >
	</xsl:text>
		<xsl:text >[m2]</xsl:text>
			<xsl:value-of select="translation/@value"/>
		<xsl:text >[/m]</xsl:text>

<xsl:text >

</xsl:text>

	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
