<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:EAD="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ablieferung - Provenienz - Ordnungsystem -->
	<xsl:template match="arelda:ablieferung">
		<!-- 3.1.4 Verzeichnungsstufe -->
		<xsl:attribute name="level">otherlevel</xsl:attribute>
		<xsl:attribute name="otherlevel">Bestand</xsl:attribute>
		<xsl:element name="EAD:did">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="EAD:unitid">
				<xsl:attribute name="label">refCode</xsl:attribute>
				<xsl:choose>
					<xsl:when test="arelda:provenienz/arelda:systemName/text()">
						<xsl:variable name="ref">
							<xsl:value-of select="arelda:provenienz/arelda:systemName"/>
							<xsl:if test="arelda:ordnungssystem/arelda:generation/text()">
								<xsl:text>: </xsl:text>
								<xsl:value-of select="arelda:ordnungssystem/arelda:generation"/>
							</xsl:if>
						</xsl:variable>
						<xsl:value-of select="arelda:EADreference($ref)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:EADreference(arelda:ablieferungsnummer)"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.2 Titel -->
			<xsl:element name="EAD:unittitle">
				<xsl:attribute name="label">main</xsl:attribute>
				<xsl:choose>
					<xsl:when test="arelda:provenienz/arelda:registratur/text()">
						<xsl:value-of select="arelda:provenienz/arelda:registratur"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<xsl:element name="EAD:unitdate">
				<xsl:attribute name="label">creationPeriod</xsl:attribute>
				<xsl:choose>
					<xsl:when test="arelda:entstehungszeitraum">
						<xsl:call-template name="EADdate">
							<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
						<xsl:call-template name="EADdate">
							<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="EAD:origination">
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!-- 3.6.1 Allgemeine Anmerkungen -->
		<xsl:if test="arelda:bemerkung/text() or arelda:provenienz/arelda:bemerkung/text() or arelda:ordnungssystem/arelda:bemerkung/text()">
			<xsl:element name="EAD:note">
				<xsl:if test="arelda:bemerkung/text()">
					<xsl:element name="EAD:p">
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:provenienz/arelda:bemerkung/text()">
					<xsl:element name="EAD:p">
						<xsl:value-of select="arelda:provenienz/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:ordnungssystem/arelda:bemerkung/text()">
					<xsl:element name="EAD:p">
						<xsl:value-of select="arelda:ordnungssystem/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:if>
		<!-- 3.1.5 Umfang (Menge und Abmessung) -->
		<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
		<xsl:if test="arelda:provenienz/arelda:geschichteAktenbildner/text()">
			<xsl:element name="EAD:bioghist">
				<xsl:element name="EAD:p">
					<xsl:value-of select="arelda:provenienz/arelda:geschichteAktenbildner"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.2.3 Bestandesgeschichte -->
		<xsl:if test="arelda:provenienz/arelda:systemBeschreibung/text()">
			<xsl:element name="EAD:custodhist">
				<xsl:element name="EAD:p">
					<xsl:value-of select="arelda:provenienz/arelda:systemBeschreibung/text()"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.2.4 Abgebende Stelle -->
		<xsl:if test="arelda:ablieferndeStelle/text()">
			<xsl:element name="EAD:acqinfo">
				<xsl:element name="EAD:p">
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.3.1 Form und Inhalt -->
		<!--   -->
		<!-- 3.3.2 Bewertung und Kassation -->
		<xsl:if test="arelda:referenzBewertungsentscheid/text()">
			<xsl:element name="EAD:appraisal">
				<xsl:element name="EAD:p">
					<xsl:value-of select="arelda:referenzBewertungsentscheid"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.4.1 Zugangsbestimmungen -->
		<xsl:element name="EAD:accessrestrict">
			<xsl:attribute name="type">restrict</xsl:attribute>
			<xsl:element name="EAD:p">
				<xsl:text>ToDo</xsl:text>
			</xsl:element>
		</xsl:element>
		<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
		<!--   -->
	</xsl:template>
</xsl:stylesheet>