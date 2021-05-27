var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
import AWS from 'aws-sdk';
var fileId = "8c63b0c5-306e-44ab-ae70-6ebfe6ad3618";
var documentUuid = "asd3b0c5-306e-44ab-ae70-6ebfe6ad3618";
var s3Bucket = "prod-author-orchestration-documents";
var s3Path = "sam-test-org/reviews/guid/guid-mydocument.pdf";
var orgId = "sam-test-org";
var mode = "CHECKLIST";
var documentTypeUuids = null; //is this no longer needed?
var params = {};
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
function publishSns(payload) {
    return __awaiter(this, void 0, void 0, function () {
        var params, publishTextPromise, result;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    AWS.config.update({ region: 'us-east-1' });
                    params = {
                        Message: JSON.stringify(payload),
                        TopicArn: "TOPIC_ARN"
                    };
                    publishTextPromise = new AWS.SNS({ apiVersion: '2010-03-31' }).publish(params).promise();
                    return [4 /*yield*/, publishTextPromise];
                case 1:
                    result = _a.sent();
                    result.MessageId;
                    return [2 /*return*/];
            }
        });
    });
}
(function () { return publishSns(payload); })();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiLi8iLCJzb3VyY2VzIjpbImluZGV4LnRzIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiI7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7Ozs7OztBQUFBLE9BQU8sR0FBRyxNQUFNLFNBQVMsQ0FBQztBQUcxQixJQUFJLE1BQU0sR0FBRyxzQ0FBc0MsQ0FBQztBQUNwRCxJQUFJLFlBQVksR0FBRyxzQ0FBc0MsQ0FBQztBQUMxRCxJQUFJLFFBQVEsR0FBRyxxQ0FBcUMsQ0FBQztBQUNyRCxJQUFJLE1BQU0sR0FBRywrQ0FBK0MsQ0FBQztBQUM3RCxJQUFJLEtBQUssR0FBRyxjQUFjLENBQUM7QUFDM0IsSUFBSSxJQUFJLEdBQUcsV0FBVyxDQUFDO0FBQ3ZCLElBQUksaUJBQWlCLEdBQUcsSUFBSSxDQUFDLENBQUEsMkJBQTJCO0FBQ3hELElBQUksTUFBTSxHQUFHLEVBQUUsQ0FBQztBQUNoQixxRUFBcUU7QUFFckUsSUFBSSxPQUFPLEdBQUc7SUFDWixNQUFNLEVBQUUsTUFBTTtJQUNkLFlBQVksRUFBRSxZQUFZO0lBQzFCLFFBQVEsRUFBRSxRQUFRO0lBQ2xCLE1BQU0sRUFBRSxNQUFNO0lBQ2QsS0FBSyxFQUFFLEtBQUs7SUFDWixJQUFJLEVBQUUsSUFBSTtJQUNWLGlCQUFpQixFQUFFLGlCQUFpQjtJQUNwQyxNQUFNLEVBQUUsTUFBTTtDQUNmLENBQUM7QUFFRixTQUFlLFVBQVUsQ0FBQyxPQUFPOzs7Ozs7b0JBRS9CLEdBQUcsQ0FBQyxNQUFNLENBQUMsTUFBTSxDQUFDLEVBQUUsTUFBTSxFQUFFLFdBQVcsRUFBRSxDQUFDLENBQUM7b0JBRXZDLE1BQU0sR0FBRzt3QkFDWCxPQUFPLEVBQUUsSUFBSSxDQUFDLFNBQVMsQ0FBQyxPQUFPLENBQUM7d0JBQ2hDLFFBQVEsRUFBRSxXQUFXO3FCQUN0QixDQUFDO29CQUdFLGtCQUFrQixHQUFHLElBQUksR0FBRyxDQUFDLEdBQUcsQ0FBQyxFQUFFLFVBQVUsRUFBRSxZQUFZLEVBQUUsQ0FBQyxDQUFDLE9BQU8sQ0FBQyxNQUFNLENBQUMsQ0FBQyxPQUFPLEVBQUUsQ0FBQztvQkFFaEYscUJBQU0sa0JBQWtCLEVBQUE7O29CQUFqQyxNQUFNLEdBQUcsU0FBd0I7b0JBRXJDLE1BQU0sQ0FBQyxTQUFTLENBQUM7Ozs7O0NBRWxCO0FBRUQsQ0FBQyxjQUFJLE9BQUEsVUFBVSxDQUFDLE9BQU8sQ0FBQyxFQUFuQixDQUFtQixDQUFDLEVBQUUsQ0FBQyJ9