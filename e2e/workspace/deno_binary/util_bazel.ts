export function getBazelWorkspaceRoot() {
  return Deno.env.get('BUILD_WORKSPACE_DIRECTORY');
}
