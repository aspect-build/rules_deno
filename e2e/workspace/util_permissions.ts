const PERMISSION_NAMES = ['run', 'read', 'write', 'net', 'env', 'ffi', 'hrtime'] as const;
type Permission = typeof PERMISSION_NAMES[number];

export async function getPermissions(): Promise<Record<Permission, Deno.PermissionState>> {
  const promises: Partial<Record<Permission, Promise<Deno.PermissionStatus>>> = {};
  for (const p of PERMISSION_NAMES) {
    promises[p] = Deno.permissions.query({name: p});
  }
  const states: Partial<Record<Permission, Deno.PermissionState>> = {};
  for (const p of PERMISSION_NAMES) {
    const status = await promises[p];
    if (status != null) {
      states[p] = status.state;
    }
  }
  return states as Record<Permission, Deno.PermissionState>;
}
