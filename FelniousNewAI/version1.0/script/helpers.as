#include "define.as"
#include "types/ai_role.as"

void LogUtil(string message, int level) {
    if (LOG_LEVEL >= level) {
        AiLog(":::AI LOG:S:" + ai.skirmishAIId + ":T:" + ai.teamId + ":F:" + ai.frame + ":L:" + ":" + message);
    } 
}

void LogUtil(string message, AiRole aiRole, int level) {
    if (LOG_LEVEL >= level) {
        AiLog(":::AI LOG:S:" + ai.skirmishAIId + ":T:" + ai.teamId + ":F:" + ai.frame + ":L:" + ":R:" + aiRole + ":" + message);
    } 
}

//This is a dumb way to choose the AI roles. It is for lack of a better method while I restructure the code
//TODO: Replace with a Smrt function
AiRole GetRandomAiRole() {
     // Use the AiDice function to select based on weights
    int choice = AiRandom(0, 2);
    LogUtil("RoleChoice:" + choice, 1);
    return AiRole(choice);  // Convert integer index to AiRole enum
}