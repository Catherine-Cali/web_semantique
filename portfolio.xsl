<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
    <html>
        <head>
        <title><xsl:value-of select="page/header/title"/></title>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
        </head>
        <body>


        <h1><xsl:value-of select="page/header/title"/></h1>
        <h2><xsl:value-of select="page/header/subtitle"/></h2>

        <!-- Navigation -->
        <nav>
        <logo img="{page/header/nav/logo/@img}" alt="{page/header/nav/logo/@alt}" />
        <menu>
            <xsl:for-each select="page/header/nav/menu/item">
            <button id="{@id}">
                <xsl:value-of select="." />
            </button>
            </xsl:for-each>
            <xsl:for-each select="page/header/nav/menu/lang">
            <img class="lang-icon" src="{@icon}" alt="{@code}" />
            </xsl:for-each>
        </menu>
        <themeToggle id="toggle-theme" icon="ressources/fr_flag.png"></themeToggle>
        </nav>


        <!-- À propos -->
        <section id="a-propos">
          <h2><xsl:value-of select="page/main/section[@id='a-propos']/title"/></h2>
          <p><xsl:value-of select="page/main/section[@id='a-propos']/text"/></p>
          <img>
            <xsl:attribute name="src"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@src"/></xsl:attribute>
            <xsl:attribute name="alt"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@alt"/></xsl:attribute>
            <xsl:attribute name="width">150</xsl:attribute>
          </img>
        </section>

        <!-- Vidéo -->
        <section id="video">
          <h2><xsl:value-of select="page/main/section[@id='video']/title"/></h2>
          <p><xsl:value-of select="page/main/section[@id='video']/subtitle"/></p>
          <iframe width="560" height="315">
            <xsl:attribute name="src"><xsl:value-of select="page/main/section[@id='video']/video/@src"/></xsl:attribute>
            <xsl:attribute name="frameborder">0</xsl:attribute>
            <xsl:attribute name="allowfullscreen">true</xsl:attribute>
          </iframe>
        </section>

        <!-- Langues -->

        <footer style="margin-top: 40px;">
          <p><xsl:value-of select="page/footer/copyright"/></p>
        </footer>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>


