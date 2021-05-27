import AWS, { SNS } from 'aws-sdk';

var fileId = "8c63b0c5-306e-44ab-ae70-6ebfe6ad3618";
var documentUuid = "asd3b0c5-306e-44ab-ae70-6ebfe6ad3618";
var s3Bucket = "prod-author-orchestration-documents";
var s3Path = "sam-test-org/reviews/guid/guid-mydocument.pdf";
var orgId = "sam-test-org";
var mode = "CHECKLIST";
var documentTypeUuids = null;//is this no longer needed?
var params = {"CurrentDate": new Date()};
//params.checklistTemplateUUID - 1d682125-d108-495f-8875-d6720b434849

var payload = {
  fileId: fileId,
  documentUUID: documentUuid,
  s3Bucket: s3Bucket,
  s3Path: s3Path,
  orgID: orgId,
  mode: mode,
  documentTypeUUIDs: documentTypeUuids,
  params: params
};
var snsTopicArn = "arn:aws:sns:us-east-1:750265728108:testsamd20210513022306729900000005";

async function publishSns(snsTopicArn, payload) {

  AWS.config.update({ region: 'us-east-1' });

  var filter: SNS.MessageAttributeMap = {
    "priority": {
      DataType: "String",
      StringValue: "fast"
    }
  };

  var params: SNS.Types.PublishInput = {
    Message: JSON.stringify(payload),
    TopicArn: snsTopicArn,
    MessageAttributes: filter
  };

  var publishTextPromise = new AWS.SNS({ apiVersion: '2010-03-31' }).publish(params).promise();

  var result = await publishTextPromise;

  result.MessageId;
  console.log(new Date());
  console.log(result);

}

(() => publishSns(snsTopicArn, payload))();