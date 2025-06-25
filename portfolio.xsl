<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <xsl:variable name="lang" select="page/@lang"/>
    <xsl:variable name="pageId" select="page/@id"/>
    <html
      xmlns="http://www.w3.org/1999/xhtml"
      xmlns:foaf="http://xmlns.com/foaf/0.1/"
      xmlns:dc="http://purl.org/dc/terms/"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
      vocab="http://xmlns.com/foaf/0.1/"
      typeof="foaf:PersonalProfileDocument"
      lang="{$lang}"
    >
      <head>
        <title property="dc:title">Portfolio de Cath <xsl:value-of select="page/main/section[@id='a-propos']/photo/@alt"/></title>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
      </head>
      <body>

        <!-- Barre de navigation -->
        <nav>
          <div class="nav-content">
            <div class="menu">
              <xsl:for-each select="page/header/nav/menu/item">
                <button id="{@id}" onclick="loadXMLXSL('{$lang}/{@id}.xml','portfolio.xsl','{@id}','{$lang}')">
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

        <!-- Contenu principal -->
        <xsl:choose>
          <xsl:when test="$pageId = 'accueil'">
            <!-- SECTION A PROPOS -->
            <section id="a-propos" typeof="foaf:Person" resource="#me">
              <h2 property="dc:title"><xsl:value-of select="page/main/section[@id='a-propos']/title"/></h2>
              <p property="foaf:description"><xsl:value-of select="page/main/section[@id='a-propos']/text"/></p>
              <img property="foaf:img">
                <xsl:attribute name="src"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@src"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="page/main/section[@id='a-propos']/photo/@alt"/></xsl:attribute>
                <xsl:attribute name="width">200</xsl:attribute>
              </img>
            </section>

 <section id="video">
<xsl:if test="embed[@type='video']">
  <iframe width="560" height="315"
          frameborder="0"
          allowfullscreen="true"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture">
    <xsl:attribute name="src">
      <xsl:value-of select="embed[@type='video']/@src"/>
    </xsl:attribute>
  </iframe>
</xsl:if>
  </section>

        </xsl:when>

          <xsl:when test="$pageId = 'projets'">
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
                        <xsl:attribute name="src">
                          <xsl:value-of select="image/@src"/>
                        </xsl:attribute>
                        <xsl:attribute name="alt">
                          <xsl:value-of select="image/@alt"/>
                        </xsl:attribute>
                        <xsl:attribute name="style">
                          <xsl:text>max-width: 50%; margin-top: 15px; border-radius: 8px;</xsl:text>
                        </xsl:attribute>
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

          <xsl:otherwise>
            <xsl:variable name="exp" select="page/main/section[@id='experiences']"/>
            <section id="experiences">
              <h2><xsl:value-of select="$exp/title"/></h2>
              <xsl:for-each select="$exp/experience">
                <div class="card" typeof="foaf:Organization">
                  <h3 property="dc:title"><xsl:value-of select="poste"/></h3>
                  <p>
                    <strong property="foaf:name"><xsl:value-of select="employeur"/></strong> — 
                    <span property="foaf:based_near"><xsl:value-of select="lieu"/></span>
                  </p>
                  <p><em property="dc:date"><xsl:value-of select="periode"/></em></p>
                  <ul>
                    <xsl:for-each select="missions/mission">
                      <li property="dc:description"><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </xsl:for-each>
            </section>

            <xsl:for-each select="page/main/section[@id='formation']">
              <section id="formation">
                <h2><xsl:value-of select="title"/></h2>
                <xsl:for-each select="diplome">
                  <div class="card" typeof="schema:EducationalOccupationalProgram" resource="#edu{position()}">
                    <h3 property="schema:name"><xsl:value-of select="intitule"/></h3>
                    <p property="schema:educationalProgram"><xsl:value-of select="etablissement"/></p>
                    <p><em property="schema:startDate"><xsl:value-of select="periode"/></em></p>
                  </div>
                </xsl:for-each>
              </section>
            </xsl:for-each>

            <xsl:for-each select="page/main/section[@id='competences']">
              <section id="competences">
                <div class="card" typeof="foaf:Person" resource="#me">
                  <h2><xsl:value-of select="title"/></h2>
                  <ul>
                    <xsl:for-each select="list/item">
                      <li property="schema:skills"><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </section>
            </xsl:for-each>

            <xsl:for-each select="page/main/section[@id='langues']">
              <section id="langues">
                <div class="card" typeof="foaf:Person" resource="#me">
                  <h2><xsl:value-of select="title"/></h2>
                  <ul>
                    <xsl:for-each select="list/item">
                      <li property="schema:knowsLanguage"><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </section>
            </xsl:for-each>

            <xsl:for-each select="page/main/section[@id='loisirs']">
              <section id="loisirs">
                <div class="card" typeof="foaf:Person" resource="#me">
                  <h2><xsl:value-of select="title"/></h2>
                  <ul>
                    <xsl:for-each select="list/item">
                      <li property="schema:interest"><xsl:value-of select="."/></li>
                    </xsl:for-each>
                  </ul>
                </div>
              </section>
            </xsl:for-each>
          </xsl:otherwise>
        </xsl:choose>

        <!-- Section Contact -->
        <xsl:if test="page/main/section[@id='contact']">
          <section id="contact" typeof="foaf:Person" resource="#me">
            <h2 property="dc:title"><xsl:value-of select="page/main/section[@id='contact']/title"/></h2>
            <div class="contact-links">
              <xsl:for-each select="page/main/section[@id='contact']/link">
                <a class="contact-link" target="_blank">
                  <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
                  <xsl:if test="@rel"><xsl:attribute name="rel"><xsl:value-of select="@rel"/></xsl:attribute></xsl:if>
                  <xsl:if test="@typeof"><xsl:attribute name="typeof"><xsl:value-of select="@typeof"/></xsl:attribute></xsl:if>
                  <img>
                    <xsl:attribute name="src"><xsl:value-of select="img/@src"/></xsl:attribute>
                    <xsl:attribute name="alt"><xsl:value-of select="img/@alt"/></xsl:attribute>
                  </img>
                  <span><xsl:value-of select="."/></span>
                </a>
              </xsl:for-each>
            </div>
          </section>
        </xsl:if>

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