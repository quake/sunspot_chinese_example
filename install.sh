#! /bin/sh
mkdir tmp
cd tmp
wget https://github.com/sunspot/sunspot/tarball/v2.0.0.pre.111215
tar zxf v2.0.0.pre.111215
mv sunspot-sunspot-6489d63/ sunspot
wget http://mmseg4j.googlecode.com/files/mmseg4j-1.8.3.zip
unzip mmseg4j-1.8.3.zip -d mmseg4j
cd ..
cp tmp/sunspot/sunspot_solr/solr sunspot_solr_mmseg4j -r
cp tmp/mmseg4j/data sunspot_solr_mmseg4j/solr/dict -r
mkdir -p tmp/WEB-INF/lib
cp tmp/mmseg4j/mmseg4j-all-1.8.3.jar tmp/WEB-INF/lib
sed 's,class="solr.StandardTokenizerFactory",class="com.chenlb.mmseg4j.solr.MMSegTokenizerFactory" mode="max-word" dicPath="dict",g' -i sunspot_solr_mmseg4j/solr/conf/schema.xml
jar uf sunspot_solr_mmseg4j/webapps/solr.war -C tmp WEB-INF/lib/mmseg4j-all-1.8.3.jar
rm -rf tmp
echo "******************"
echo "** install done **"
echo "******************"
echo "cd sunspot_solr_mmseg4j and run 'java -jar start.jar' to start jetty"
echo "visit http://localhost:8983/solr/ to verify result" 
