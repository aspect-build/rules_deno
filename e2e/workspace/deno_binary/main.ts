import * as colors from 'https://deno.land/std@0.153.0/fmt/colors.ts';
import { canUseColor } from './helper.ts';
import { getBazelWorkspaceRoot } from './util_bazel.ts';
import { getPermissions } from './util_permissions.ts';

const permissions = await getPermissions();

const useColor = canUseColor();
console.log({
  denoCacheDir: Deno.env.get('DENO_DIR'),
  args: Deno.args,
  version: Deno.version,
  workspaceRoot: getBazelWorkspaceRoot(),
  permissions,
  useColor,
});

if (useColor) {
  console.log(colors.bgWhite(colors.blue('I\'ve a feeling we\'re not in Kansas any more.')));
} else {
  console.log('Aww, no technicolor for you.');
}

if (Deno.args.length > 0) {
  await Deno.writeTextFile(Deno.args[0], JSON.stringify(permissions));
}
