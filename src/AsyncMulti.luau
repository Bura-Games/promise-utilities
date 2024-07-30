--!optimize 2
--!strict

local PackRest = require(script.Parent.PackRest)
local Promise = require(script.Parent.Parent.Promise)

--[=[
	A function that turns another function into the same as an async function
	in ECMAScript. This supports multiple returns however.

	```ts
	async function promiseUpperAndLower(value: string) {
		return [value.toUpperCase(), value.toLowerCase()];
	}
	```

	would basically be equivalent to:

	```lua
	local function GetUpperAndLowerAsync(value: string)
		return string.upper(value), string.lower(value)
	end

	local PromiseUpperAndLower = PromiseUtilities.AsyncMulti(GetUpperAndLowerAsync)
	```

	:::info
	This is meant to be entirely equivalent to the TypeScript version. I would
	recommend using [PromiseUtilities.FastAsyncMulti] instead for better
	performance.
	:::

	@function AsyncMulti
	@within PromiseUtilities

	@param callback (Arguments...) -> Returns...
	@return (Arguments...) -> Promise<Returns...>
]=]
local function AsyncMulti<Arguments..., Returns...>(callback: (Arguments...) -> Returns...)
	local function asyncFunction(...: Arguments...): Promise.TypedPromise<Returns...>
		local arguments = {select(1, ...)}
		local length = select("#", ...)

		return Promise.new(function(resolve, reject)
			coroutine.wrap(function()
				local success, values = PackRest(pcall(callback, table.unpack(arguments, 1, length)))
				if success then
					resolve(table.unpack(values, 1, values.n))
				else
					reject(table.unpack(values, 1, values.n))
				end
			end)()
		end)
	end

	return asyncFunction
end

return AsyncMulti
