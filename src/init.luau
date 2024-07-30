--!native
--!optimize 2
--!strict

local Promise = require(script.Parent.Promise)

local Async = require(script.Async)
local Await = require(script.Await)
local AwaitMulti = require(script.AwaitMulti)
local FastAsync = require(script.FastAsync)

export type Error = Promise.Error
export type ErrorKind = Promise.ErrorKind
export type Status = Promise.Status

export type Promise<T...> = Promise.TypedPromise<T...>
export type VoidPromise = Promise.Promise

--[=[
	Utilities for working with Promises.
	@class PromiseUtilities
]=]
local PromiseUtilities = table.freeze({
	Async = Async;
	Await = Await;
	AwaitMulti = AwaitMulti;
	FastAsync = FastAsync;
})

return PromiseUtilities
