<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:variable name="x" select="count(//Initialize/StepGroup[@result='Failed']//Step[@result != 'Failed'])"/>
<xsl:variable name="y" select="count(//Initialize/StepGroup[@result='Failed']//Step[@result = 'Failed'])"/>
<xsl:variable name="passedInitGroups" select="count(//Initialize/StepGroup[@result='Passed'])"/>

<!-- init assumptions
     has only one StepGroup with no nested StepGroups
-->
<xsl:template match="Initialize">
<testsuites>
   <xsl:for-each select = "StepGroup[@result='Failed']">
    <testsuite>

     <xsl:attribute name="name">
          <xsl:value-of select="current()/@name"/>
     </xsl:attribute>

     <xsl:attribute name="status">
          <xsl:value-of select="'Failed'"/>
     </xsl:attribute>

     <xsl:attribute name="time">
                 <xsl:value-of select="current()/@duration*0.001"/>
     </xsl:attribute>

    <stepGroup>
      <xsl:value-of select="concat('Failed group name=',current()/@name)"/>
    </stepGroup>
          <xsl:for-each select="current()//Step">
            <testcase>
             <xsl:attribute name="name">
                 <xsl:value-of select="current()/@name"/>
              </xsl:attribute>
              <xsl:attribute name="status">
                 <xsl:value-of select="current()/@result"/>
              </xsl:attribute>
              <xsl:attribute name="time">
                 <xsl:value-of select="current()/@duration*0.001"/>
              </xsl:attribute>
              <xsl:if test="current()/@result='Failed'">
                   <failure>
                    <xsl:attribute name="message">
                       <xsl:value-of select="current()/@summary"/>
                    </xsl:attribute>

                   </failure>
              </xsl:if>
            </testcase>
           </xsl:for-each>
         </testsuite>
</xsl:for-each>
<failed_g>
      <xsl:value-of select="concat('Ok steps under failed group =',$x)"/>
</failed_g>
<failed_g2>
      <xsl:value-of select="concat('Failed steps under failed groups=',$y)"/>
</failed_g2>
<passedInitGroups>
      <xsl:value-of select="concat('Passed groups under Init=',$passedInitGroups)"/>
</passedInitGroups>
</testsuites>
</xsl:template>
<!-- Run assumptions
     - might have (or might not) many StepGroups all of them are top level. StepGroups does not have nested StepGroups inside them. StepGroups has nested structure of steps inside steps with different types.
     - might have (or might not) top level steps w.o parent StepGroups
-->
<xsl:template match="Run">
                   <xsl:for-each select="current()//Step">
                           <node>
 <xsl:attribute name="name">
                       <xsl:value-of select="current()/@name"/>
                    </xsl:attribute>

<xsl:attribute name="xxxx">
<xsl:value-of select="current()/@name"/>
</xsl:attribute>

                                 <xsl:value-of select="local-name()"/>
                           </node>
                   </xsl:for-each>
</xsl:template>

</xsl:stylesheet>