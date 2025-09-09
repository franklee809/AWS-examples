### Bucket 

aws s3api select-object-content \
--bucket frank-example-ab2-solution-architect \
--key test.json \
--expression "select * from s3object limit 10" \
--expression-type "SQL" \
--input-serialization '{"JSON": {"Type": "Document"}}' \
--output-serialization '{"JSON": {}}' output.json
