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

        <!-- Menu -->
        <nav>
          <div class="nav-content">
            <div class="menu">
              <xsl:for-each select="page/header/nav/menu/item">
                <button id="{@id}" onclick="loadXMLXSL('{/page/@lang}/{@id}.xml','portfolio.xsl','{@id}','{/page/@lang}')">
                  <xsl:value-of select="."/>
                </button>
              </xsl:for-each>
            </div>
            <div class="lang-switch">
              <xsl:for-each select="page/header/nav/menu/lang">
                <img class="lang-icon">
                  <xsl:attribute name="src"><xsl:value-of select="@icon"/></xsl:attribute>
                  <xsl:attribute name="alt"><xsl:value-of select="@code"/></xsl:attribute>
                  <xsl:attribute name="onclick">
                    <xsl:text>loadXMLXSL('</xsl:text>
                    <xsl:value-of select="@code"/>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="/page/@id"/>
                    <xsl:text>.xml','portfolio.xsl','</xsl:text>
                    <xsl:value-of select="/page/@id"/>
                    <xsl:text>','</xsl:text>
                    <xsl:value-of select="@code"/>
                    <xsl:text>')</xsl:text>
                  </xsl:attribute>
                </img>
              </xsl:for-each>
            </div>
          </div>
        </nav>

        <xsl:choose>

          <!-- Accueil -->
          <xsl:when test="/page/@id = 'accueil'">
            <section id="a-propos">
              <h2><xsl:value-of select="page/main/section[@id='a-propos']/title"/></h2>
              <p><xsl:value-of select="page/main/section[@id='a-propos']/text"/></p>
              <img>
                <xsl:attribute name="src"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@src"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@alt"/></xsl:attribute>
                <xsl:attribute name="width">200</xsl:attribute>
              </img>
            </section>

            <section id="video">
              <h2><xsl:value-of select="page/main/section[@id='video']/title"/></h2>
              <p><xsl:value-of select="page/main/section[@id='video']/subtitle"/></p>
              <iframe width="560" height="315">
                <xsl:attribute name="src"><xsl:value-of select="page/main/section[@id='video']/video/@src"/></xsl:attribute>
                <xsl:attribute name="frameborder">0</xsl:attribute>
                <xsl:attribute name="allowfullscreen">true</xsl:attribute>
              </iframe>
            </section>
          </xsl:when>

          <!-- Projets -->
          <xsl:when test="/page/@id = 'projets'">
            <section id="projets">
              <xsl:for-each select="page/main/section[@id='projets']/projet">
                <div class="card">
                  <h2><xsl:value-of select="titre"/></h2>
                  <h4 style="color: gray;"><xsl:value-of select="categorie"/></h4>

                  <div>
                    <xsl:for-each select="technos/techno">
                      <span style="display: inline-block; background-color: #eee; padding: 5px 10px; margin: 2px; border-radius: 10px; font-family: monospace;">
                        <xsl:value-of select="."/>
                      </span>
                    </xsl:for-each>
                  </div>

                  <xsl:if test="image">
                    <img>
                      <xsl:attribute name="src"><xsl:value-of select="image/@src"/></xsl:attribute>
                      <xsl:attribute name="alt"><xsl:value-of select="image/@alt"/></xsl:attribute>
                      <xsl:attribute name="style">max-width: 100%; margin-top: 15px; border-radius: 8px;</xsl:attribute>
                    </img>
                  </xsl:if>

                  <ul>
                    <xsl:for-each select="description/point">
                      <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </xsl:for-each>
            </section>
          </xsl:when>

          <!-- CV et autres sections -->
          <xsl:otherwise>

            <section id="profil">
              <div class="card">
                <h3><xsl:value-of select="page/main/section[@id='profil']/title"/></h3>
                <p><xsl:value-of select="page/main/section[@id='profil']/text"/></p>
              </div>
            </section>

            <section id="experiences">
              <h2><xsl:value-of select="page/main/section[@id='experiences']/title"/></h2>
              <xsl:for-each select="page/main/section[@id='experiences']/experience">
                <div class="card">
                  <h3><xsl:value-of select="poste"/></h3>
                  <p><strong><xsl:value-of select="employeur"/></strong> — <xsl:value-of select="lieu"/></p>
                  <p><em><xsl:value-of select="periode"/></em></p>
                  <ul>
                    <xsl:for-each select="missions/mission">
                      <li><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </xsl:for-each>
            </section>

            <section id="formation">
              <h2><xsl:value-of select="page/main/section[@id='formation']/title"/></h2>
              <xsl:for-each select="page/main/section[@id='formation']/diplome">
                <div class="card">
                  <h3><xsl:value-of select="intitule"/></h3>
                  <p><xsl:value-of select="etablissement"/></p>
                  <p><em><xsl:value-of select="periode"/></em></p>
                </div>
              </xsl:for-each>
            </section>

            <section id="competences">
              <div class="card">
                <h2><xsl:value-of select="page/main/section[@id='competences']/title"/></h2>
                <ul>
                  <xsl:for-each select="page/main/section[@id='competences']/list/item">
                    <li><xsl:value-of select="."/></li>
                  </xsl:for-each>
                </ul>
              </div>
            </section>

            <section id="langues">
              <div class="card">
                <h2><xsl:value-of select="page/main/section[@id='langues']/title"/></h2>
                <ul>
                  <xsl:for-each select="page/main/section[@id='langues']/list/item">
                    <li><xsl:value-of select="."/></li>
                  </xsl:for-each>
                </ul>
              </div>
            </section>

            <section id="loisirs">
              <div class="card">
                <h2><xsl:value-of select="page/main/section[@id='loisirs']/title"/></h2>
                <ul>
                  <xsl:for-each select="page/main/section[@id='loisirs']/list/item">
                    <li><xsl:value-of select="."/></li>
                  </xsl:for-each>
                </ul>
              </div>
            </section>

          </xsl:otherwise>
        </xsl:choose>

        <!-- Footer -->
        <footer>
          <p>
            <xsl:if test="page/footer/copyright">
              <xsl:value-of select="page/footer/copyright"/>
            </xsl:if>
          </p>
        </footer>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
