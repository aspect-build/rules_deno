import {canUseColor} from './helper.ts';
import {getBazelWorkspaceRoot} from './util_bazel.ts';
import {getPermissions} from './util_permissions.ts';

const permissions = await getPermissions();

console.log({
  args: Deno.args,
  version: Deno.version,
  workspaceRoot: getBazelWorkspaceRoot(),
  permissions,
  useColor: canUseColor(),
});

if (Deno.args.length > 0) {
  await Deno.writeTextFile(Deno.args[0], JSON.stringify(permissions));
}
