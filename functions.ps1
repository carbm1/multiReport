function New-CognosPage($table) {

    $page = '
    <page name="{{table}}_PAGE">
    <pageBody>
        <contents>
            <list horizontalPagination="true" refQuery="{{table}}_QUERY" name="List1">
                <listColumns>
                    {{listcolumn}}
                </listColumns>
            </list>
        </contents>
    </pageBody>
    <conditionalRender refVariable="useTbl">
        <renderFor refVariableValue="{{table}}"/>
    </conditionalRender>
    </page>' -replace '{{table}}',$table

    return $page

}

function New-CognosPageColumn($name) {

    $listColumn = '
    <listColumn>
        <listColumnTitle>
            <contents>
                <textItem>
                    <dataSource>
                        <dataItemLabel refDataItem="{{name}}"/>
                    </dataSource>
                </textItem>
            </contents>
        </listColumnTitle>
        <listColumnBody>
            <contents>
                <textItem>
                    <dataSource>
                        <dataItemValue refDataItem="{{name}}"/>
                    </dataSource>
                </textItem>
            </contents>
        </listColumnBody>
    </listColumn>' -replace '{{name}}',$name

    return $listColumn

}

function New-CognosQuery($table) {
    $query = '
    <query name="{{table}}_QUERY">
        <source>
            <sqlQuery name="{{table}}_SQL" dataSource="gentrysms">
                <sqlText>SELECT * FROM {{table}}</sqlText>
            </sqlQuery>
        </source>
        <selection>
            {{DATAITEMS}}
        </selection>
    </query>' -replace '{{table}}',$table

    return $query
}

function New-CognosQueryDataItem($table,$item) {
    
    $dataitem = '
    <dataItem name="{{item}}">
        <expression>[{{table}}_SQL].[{{item}}]</expression>
    </dataItem>' -replace '{{table}}',$table -replace '{{item}}',$item
    
    return $dataitem
}

function New-CognosReport() {

    $minRequired = '    
    <report xmlns="http://developer.cognos.com/schemas/report/15.5/" useStyleVersion="11.6" expressionLocale="en">
        <drillBehavior/>

        <layouts>
            <layout>
                <reportPages>
                    {{PAGES}}
                </reportPages>
            </layout>
        </layouts>

        <queries>
            {{QUERIES}}
        </queries>
        
        <reportVariables>
            <reportVariable type="string" name="useTbl">
                <reportExpression>Paramvalue(&apos;table&apos;)</reportExpression>
                <variableValues>
                    {{VARIABLES}}
                </variableValues>
            </reportVariable>
        </reportVariables>
        
        <modelPath>/content/folder[@name=&apos;Packages&apos;]/folder[@name=&apos;Student Management System Packages&apos;]/package[@name=&apos;eSchoolPLUS Admin - Arkansas&apos;]/model[@name=&apos;model&apos;]</modelPath>
        
    </report>'

    return $minRequired

}