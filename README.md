### Encoded Archival Context (EAC)
#### Corporate Bodies, Persons, and Families (CPF)

This library enables parsing of [EAC-CPF files](http://www3.iath.virginia.edu/eac/cpf/tagLibrary/cpfTagLibrary.html).

The initial focus is to read EAC-CPF files that represent an individual person, which will have a <cpfDescription> node.  The <cpfDescription> (Corporate body, person or family description) contains information on the name structures, descriptive elements, and relationships. 


* <identity> - Identity. Complex structure containing the name or names used by the entity over the course of the entity’s existence. Contains a repeatable <nameEntry> element for different names, and a repeatable <nameEntryParallel> element for more than one <nameEntry> expressed in different languages. Required.
* <description> - Description. Contains formal description elements parallel to those in ISAAR (CPF) for the description of the entity. An additional <localDescription> allows for local implementation of additional descriptive information not included in the other <description> elements. Optional.
* <relations> - Relations. Contains one or more references to or descriptions of related corporate bodies, persons or families <cpfRelation>, functions <functionRelation>, or resources <resourceRelation>. Optional.


#### data
Sample data files from [Staatsbibliothek zu Berlin](http://eac.staatsbibliothek-berlin.de/tag-library/examples.html)

* [berlin_bach.xml](http://eac.staatsbibliothek-berlin.de/fileadmin/user_upload/schema/eac.p026064_d20120523_t171914_1.xml)
* [yale_cadell.xml](http://eac.staatsbibliothek-berlin.de/fileadmin/user_upload/schema/yale_cadell.xml)
* [sia_walcott.xml](http://eac.staatsbibliothek-berlin.de/fileadmin/user_upload/schema/SIA_Charles_Walcott_EAC.xml)
