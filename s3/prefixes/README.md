### Create a sandbox bucket
```sh
aws s3 mb s3://prefixes-fun-ab-5235123

```

### Create a folder 
```sh
aws s3api put-object --bucket="prefixes-fun-ab-5235123" --key="hello/" 
```

### Create a nested folder (restrained size 1024 bytes)
```sh
aws s3api put-object --bucket="prefixes-fun-ab-5235123" --key="Lorem/ipsum/dolor/sit/amet,/consectetur/adipiscing/elit./Ut/id/euismod/orci./Donec/eget/ante/ac/elit/luctus/suscipit./Sed/aliquet/mollis/iaculis./Class/aptent/taciti/sociosqu/ad/litora/torquent/per/conubia/nostra,/per/inceptos/himenaeos./Aliquam/accumsan,/nisl/sed/semper/bibendum,/orci/metus/posuere/nulla,/sit/amet/molestie/nisl/enim/id/ligula./Pellentesque/sed/auctor/ipsum./Donec/eget/nunc/ultricies/justo/condimentum/laoreet/sit/amet/quis/libero./In/facilisis/ut/magna/interdum/pellentesque./Aenean/vestibulum/leo/sed/malesuada/faucibus./Proin/nec/accumsan/arcu,/ut/convallis/sapien./Integer/consequat,/sem/id/condimentum/rhoncus,/nunc/nulla/tempor/dui,/vel/semper/lectus/tellus/nec/augue./Phasellus/a/tristique/nulla,/non/gravida/enim./Interdum/et/malesuada/fames/ac/ante/ipsum/primis/in/faucibus./Vivamus/in/"
```


### List all objects 
```sh
aws s3api list-objects --bucket="prefixes-fun-ab-5235123"
```