exports.handler = async function(event, context) {
  console.log("EVENT: \n" + JSON.stringify(event, null, 2));
  // console.log("CONTEXT: \n" + JSON.stringify(context, null, 2));

  var payload = JSON.parse(JSON.parse(event.Records[0].body).Message);

  console.log("PAYLOAD: \n" + payload);

  console.log("Time the message was sent: \n" + payload.params.CurrentDate)
  
  return context.logStreamName;
}