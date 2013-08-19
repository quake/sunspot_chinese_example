这是一个安装脚本，能够build和sunspot兼容的solr/mmseg4j版本，方便用来作中文的全文索引。

执行install.sh脚本以后，会在本目录下面生成一个sunspot_solr_mmseg4j目录，这里包括了jetty，solr的war文件，以及mmseg4j的集成，你只需要执行java -jar start.jar，就能够启动一个solr server。

启动后，用浏览器访问 http://localhost:8983/solr/admin/analysis.jsp

选择Field为type，输入text。 Field value (Index) 输入 “研究生研究生命科学” 。点击Analyze，如果输出“研究|生|研究|生命|科学”，就说明mmseg4j + sunspot 已经build成功。

sunspot_solr_mmseg4j这个目录可以拷贝到任意地方，作为提供全文索引的服务器。

对于高级的配置，你可以修改sunspot_solr_mmseg4j/solr/conf/schema.xml文件

比如添加index和query的分析器，让查询也需要走分词器，或者更改mmseg4j的分词模式（build好的默认是max-word）

```xml
    <fieldType name="text" class="solr.TextField" omitNorms="false">
      <analyzer type="index">
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="max-word" dicPath="mmseg4j_dict"/>
        <filter class="solr.StandardFilterFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
      </analyzer>
      <analyzer type="query">
        <tokenizer class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="max-word" dicPath="mmseg4j_dict"/>
        <filter class="solr.StandardFilterFactory"/>
        <filter class="solr.LowerCaseFilterFactory"/>
        <filter class="solr.PositionFilterFactory" />
      </analyzer>
    </fieldType>
```

或者在solr/mmseg4j_dict目录下面添加更多的自定义词库。
